"""Turn the sticker artwork in design-previews into what the app ships.

The drawings live at 512x512 and 57 frames, which is right for looking at and
wrong for an APK: seventy-two of them at three megabytes each is two hundred
megabytes, against an app that is eighty-six. So each one is re-encoded twice —
once as the animation a bubble plays, once as the still the picker draws — and
only those two land in `assets/`.

Numbers, and why they are these numbers:

  * **224 px, animated.** A sticker is drawn at 148 points, so 224 covers a 1.5x
    screen exactly and a 3x screen at half resolution — which on a drawing with
    flat colour and a heavy outline is not visible, checked by rendering one
    beside the source rather than by assuming. 256 looked no better and cost a
    third more.
  * **Every second frame.** 57 frames over 2.3 s is 25 fps; half of that is 12.5
    and reads as smooth for a loop this short. A third of it does not.
  * **quality 58, method 4.** Method 6 is the encoder's slowest setting and was
    measured at minutes per animation here — over an hour for the set, for a few
    per cent. Not worth it for something rebuilt this rarely.
  * **176 px, still.** The picker cell is a third of the screen width. This is
    the file that is drawn seventy-two times at once, so it is the one that has
    to be small.

Run it when the artwork changes:

    python tool/build_sticker_assets.py

It is not part of the build. The output is committed, because a phone cannot
run Python and a CI runner should not have to.
"""

import json
import os
import sys
from PIL import Image, ImageSequence

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "design-previews", "matcha-motion-v8")
OUT = os.path.join(ROOT, "assets", "stickers")

ANIM_SIZE = 224
# Every frame, because v8 has eight of them where v6 had fifty-seven.
#
# Dropping every second frame was right for a 25 fps flipbook and is wrong for
# a pose sheet: v8 holds a drawing for a beat and then snaps, so half its
# frames *are* the animation. Taking every other one keeps only the holds or
# only the snaps.
ANIM_STEP = 1
ANIM_QUALITY = 58
ANIM_METHOD = 4
STILL_SIZE = 176

# Cubi's source art deliberately contains poses and drawn in-betweens.  The
# gallery export keeps its six-second presentation rhythm, but that rhythm is
# wrong for an in-chat sticker: it held the key pose for 0.9–1.05 seconds, then
# jumped through the in-betweens.  On a phone this reads as a frozen sticker,
# not a living character.
#
# The app therefore plays Cubi at 12.5 fps.  Eight-frame poses gain one blended
# transition after every drawn frame, so they have the same cadence as the
# sixteen-frame poses.  This changes no illustration or silhouette: it only
# gives a short, even bridge between adjacent hand-drawn positions.
CUBI_FRAME_MS = 80
FALLBACK_FRAME_MS = 80


def frames_of(path, step, *, smooth_cubi):
    im = Image.open(path)
    out = []
    for i, frame in enumerate(ImageSequence.Iterator(im)):
        if i % step:
            continue
        out.append(frame.convert("RGBA").resize(
            (ANIM_SIZE, ANIM_SIZE), Image.LANCZOS))
    if smooth_cubi and len(out) <= 8:
        bridged = []
        for index, frame in enumerate(out):
            bridged.append(frame)
            # A half-way dissolve keeps the movement continuous without
            # inventing a new pose, which avoids the rubbery look of a rig.
            bridged.append(Image.blend(frame, out[(index + 1) % len(out)], .5))
        return bridged
    return out


def durations_of(gif_path, count, step, *, smooth_cubi):
    """Return app playback timing; Cubi always uses an even animation beat."""
    if smooth_cubi:
        return [CUBI_FRAME_MS] * count
    if not os.path.exists(gif_path):
        return [FALLBACK_FRAME_MS] * count
    im = Image.open(gif_path)
    got = [
        f.info.get("duration") or FALLBACK_FRAME_MS
        for i, f in enumerate(ImageSequence.Iterator(im))
        if i % step == 0
    ]
    if len(got) < count:
        got += [FALLBACK_FRAME_MS] * (count - len(got))
    return got[:count]


def build(name):
    animated_src = os.path.join(SRC, name + ".webp")
    still_src = os.path.join(SRC, name + ".png")
    is_cubi = name.startswith("cat-")
    frames = frames_of(animated_src, ANIM_STEP, smooth_cubi=is_cubi)
    duration = durations_of(
        os.path.join(SRC, name + ".gif"),
        len(frames),
        ANIM_STEP,
        smooth_cubi=is_cubi,
    )
    animated_dst = os.path.join(OUT, name + ".webp")
    frames[0].save(
        animated_dst,
        save_all=True,
        append_images=frames[1:],
        duration=duration,
        loop=0,
        quality=ANIM_QUALITY,
        method=ANIM_METHOD,
    )

    still = Image.open(still_src).convert("RGBA").resize(
        (STILL_SIZE, STILL_SIZE), Image.LANCZOS)
    still_dst = os.path.join(OUT, name + ".png")
    still.save(still_dst, optimize=True)

    return len(frames), os.path.getsize(animated_dst), os.path.getsize(still_dst)


def main():
    if not os.path.isdir(SRC):
        sys.exit(f"artwork not found: {SRC}")
    os.makedirs(OUT, exist_ok=True)

    names = sorted(
        f[:-5] for f in os.listdir(SRC)
        if f.endswith(".webp") and os.path.exists(
            os.path.join(SRC, f[:-5] + ".png"))
    )
    if not names:
        sys.exit("no artwork with both an animation and a still")

    total_anim = total_still = 0
    for i, name in enumerate(names, 1):
        n, a, s = build(name)
        total_anim += a
        total_still += s
        print(f"[{i:2d}/{len(names)}] {name:22s} {n:2d} frames  "
              f"{a/1024:6.0f} KB + {s/1024:5.0f} KB", flush=True)

    manifest = {
        "cats": [n for n in names if n.startswith("cat-")],
        "emoji": [n for n in names if n.startswith("emoji-")],
    }
    with open(os.path.join(OUT, "manifest.json"), "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)
        f.write("\n")

    print(f"\n{len(names)} stickers — "
          f"{total_anim/1024/1024:.1f} MB animated + "
          f"{total_still/1024/1024:.1f} MB still = "
          f"{(total_anim + total_still)/1024/1024:.1f} MB")


main()
