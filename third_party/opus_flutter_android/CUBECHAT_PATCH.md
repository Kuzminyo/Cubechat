# CubeChat patches to opus_flutter_android 3.0.1

Copied from the pub cache's `opus_flutter_android-3.0.1` and wired in as a
path override in the app's `pubspec.yaml`. An upgrade means copying the new
version here and reapplying what is below.

## libopus linked for 16 KB pages (2026-11-12)

The plugin builds libopus from source with `ndk-build` (`android/Android.mk`)
and never said what page size to link for, so `lib/arm64-v8a/libopus.so` came
out with its LOAD segments aligned to 4 KB (`p_align 0x1000`, read with
`llvm-readelf -lW` on the 1207 APK). Every other native library in the APK was
already 16 KB or more. On a phone running a 16 KB page size such a library does
not load, and Google Play refuses updates that carry one.

One line in `android/Android.mk`:

    LOCAL_LDFLAGS += -Wl,-z,max-page-size=16384 -Wl,-z,common-page-size=16384

Nothing in the library's code changes; only where its segments start in the
file. Checked after the build with `llvm-readelf -lW` on the extracted
`libopus.so`: every LOAD reads `0x4000`.
