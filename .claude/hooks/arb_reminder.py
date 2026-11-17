"""PostToolUse reminder: an edited .arb needs gen-l10n run and committed.

lib/l10n/app_localizations*.dart is generated but checked in on purpose -- CI
does not regenerate it before building. So an .arb edit that stops there
compiles fine locally off the stale generated file and breaks on the runner, or
worse, ships a build whose new string is missing. Nothing enforces the second
step, which is what this line is for.

It also compares the key sets. There are 19 ARBs, all at the same keys
(1282 on 2026-11-17), and a key added to the template alone falls back to
English in 18 locales without a word from gen-l10n. This used to name only
app_en and app_uk, from when those were the only two.

Advisory only: prints context, never blocks.
"""

import glob
import json
import os
import sys

TEMPLATE = "app_en.arb"


def keys(path):
    with open(path, encoding="utf-8") as f:
        return {k for k in json.load(f) if not k.startswith("@")}


def drift(arb_dir):
    """Lines naming each ARB whose keys differ from the template's."""
    template = os.path.join(arb_dir, TEMPLATE)
    if not os.path.exists(template):
        return []
    try:
        want = keys(template)
    except (ValueError, OSError) as e:
        return ["{} does not parse: {}".format(TEMPLATE, e)]

    lines = []
    for path in sorted(glob.glob(os.path.join(arb_dir, "app_*.arb"))):
        name = os.path.basename(path)
        if name == TEMPLATE:
            continue
        try:
            have = keys(path)
        except (ValueError, OSError) as e:
            lines.append("{} does not parse: {}".format(name, e))
            continue
        missing, extra = want - have, have - want
        if missing or extra:
            sample = sorted(missing or extra)[:3]
            lines.append(
                "{}: {} missing, {} extra (e.g. {})".format(
                    name, len(missing), len(extra), ", ".join(sample)
                )
            )
    return lines


def main():
    try:
        payload = json.load(sys.stdin)
    except (ValueError, OSError):
        return

    tool_input = payload.get("tool_input") or {}
    response = payload.get("tool_response") or {}
    path = response.get("filePath") or tool_input.get("file_path") or ""

    if not path.replace("\\", "/").lower().endswith(".arb"):
        return

    context = (
        "An .arb file was edited. Run `flutter gen-l10n` and commit the "
        "regenerated lib/l10n/app_localizations*.dart -- they are checked in "
        "and CI does not rebuild them. Every ARB carries the same key set as "
        "app_en.arb, the template."
    )
    out_of_step = drift(os.path.dirname(os.path.abspath(path)))
    if out_of_step:
        context += " Out of step with app_en.arb right now: " + "; ".join(out_of_step)
    else:
        context += " All ARBs are in step."

    json.dump(
        {
            "systemMessage": "ARB edited - run flutter gen-l10n and commit the generated files.",
            "hookSpecificOutput": {
                "hookEventName": "PostToolUse",
                "additionalContext": context,
            },
        },
        sys.stdout,
    )


if __name__ == "__main__":
    main()
