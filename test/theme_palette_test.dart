import 'dart:io';

import 'package:cubechat/core/theme/colors.dart';
import 'package:cubechat/core/theme/theme_controller.dart';
import 'package:cubechat/core/widgets/hue_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'support/hive_settle.dart';

/// A palette has to reach the interface, not just the accents on it.
///
/// The glass in this app is white at a low opacity over the aurora, and while
/// that white was literally `Colors.white` every theme produced the same grey
/// app with differently coloured buttons. What is pinned here is that choosing
/// a palette moves the white too — and that Graphite, the deliberately
/// colourless one, is left alone.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late ProviderContainer container;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('cubechat_palette_test_');
    Hive.init(tempDir.path);
    container = ProviderContainer();
  });

  tearDown(() async {
    await settleBackgroundStorage();
    container.dispose();
    await Hive.close();
    try {
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    } on FileSystemException {
      // Windows holds the Hive files briefly after close.
    }
  });

  test('an unknown id falls back to the stock look', () {
    expect(AppPalette.byId('a-palette-from-a-later-build').id, 'emerald');
    expect(AppPalette.byId(null).id, 'emerald');
  });

  test('choosing Fuchsia tints the glass and the ink, not just the brand',
      () async {
    await container
        .read(themeControllerProvider.notifier)
        .select(AppPalette.fuchsia);

    expect(AppColors.brandPrimary, AppPalette.fuchsia.brandPrimary);
    expect(AppColors.bgDeep, AppPalette.fuchsia.bgDeep);
    expect(AppColors.glassBase, isNot(Colors.white),
        reason: 'a pane of glass has to carry the palette');
    expect(AppColors.glassBase.b, lessThan(AppColors.glassBase.r),
        reason: 'pink glass, so less blue in it than red');
    expect(AppColors.glassFill, AppColors.glass(0.08));
    expect(AppColors.textOnGlass, AppColors.ink(0.95));
    // Ink is tinted too, but far less: a label is there to be read.
    expect(
      Colors.white.b - AppColors.inkBase.b,
      lessThan(Colors.white.b - AppColors.glassBase.b),
    );
  });

  test('Graphite keeps its glass neutral', () async {
    await container
        .read(themeControllerProvider.notifier)
        .select(AppPalette.fuchsia);
    await container
        .read(themeControllerProvider.notifier)
        .select(AppPalette.slate);

    expect(AppColors.glassBase, Colors.white);
    expect(AppColors.inkBase, Colors.white);
  });

  test('every palette is reachable and distinct', () {
    final ids = AppPalette.all.map((p) => p.id).toList();
    expect(ids.toSet(), hasLength(ids.length));
    for (final id in ids) {
      expect(AppPalette.byId(id).id, id);
    }
  });

  group('a hue of one\'s own', () {
    test('survives being stored as an id and read back', () {
      // The id is the whole of what is persisted, so a custom choice has to be
      // reconstructable from it — otherwise it lasts until the next launch.
      final picked = AppPalette.hue(287);
      expect(picked.isCustom, isTrue);
      expect(picked.hue, 287);
      expect(AppPalette.byId(picked.id).brandPrimary, picked.brandPrimary);
    });

    test('a nonsense custom id falls back rather than throwing', () {
      expect(AppPalette.byId('hue:').id, AppPalette.emerald.id);
      expect(AppPalette.byId('hue:banana').id, AppPalette.emerald.id);
    });

    test('the wheel wraps rather than running off either end', () {
      expect(AppPalette.hue(360).brandPrimary, AppPalette.hue(0).brandPrimary);
      expect(AppPalette.hue(-90).hue, 270);
    });

    test('every angle keeps the background dark and the brand bright', () {
      // The whole reason the wheel picks only a hue: text is read against the
      // background, and a palette that drifts light at some angle is a screen
      // nobody can use. Walked in tens rather than at a few chosen points,
      // because the failure this guards against is angle-dependent.
      for (var h = 0; h < 360; h += 10) {
        final p = AppPalette.hue(h.toDouble());
        expect(HSLColor.fromColor(p.bgDeep).lightness, lessThan(0.12),
            reason: 'the deepest background at $h is not dark');
        expect(HSLColor.fromColor(p.bgBottom).lightness, lessThan(0.22),
            reason: 'the lightest background at $h is not dark');
        expect(HSLColor.fromColor(p.brandPrimary).lightness, greaterThan(0.4),
            reason: 'the brand at $h would not stand out on it');
      }
    });

    test('applying one recolours the interface like any other', () async {
      await container
          .read(themeControllerProvider.notifier)
          .select(AppPalette.hue(30));
      expect(AppColors.brandPrimary, AppPalette.hue(30).brandPrimary);
      expect(AppColors.bgDeep, AppPalette.hue(30).bgDeep);
    });

    // Every step of a drag used to call select, which changes the id the app
    // root is keyed on: the tree, the slider under the finger with it, was
    // thrown away on the first step and the thumb stopped after one notch.
    test('a preview paints the hue without choosing it', () async {
      final notifier = container.read(themeControllerProvider.notifier);
      await notifier.loaded;
      final before = container.read(themeControllerProvider).id;
      notifier.preview(AppPalette.hue(200));
      expect(AppColors.brandPrimary, AppPalette.hue(200).brandPrimary);
      expect(container.read(themeControllerProvider).id, before);
    });

    testWidgets('a drag across the strip previews each step and chooses once',
        (tester) async {
      final steps = <double>[];
      final chosen = <double>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 360,
                child: HueStrip(
                  selected: false,
                  hue: 0,
                  onPick: steps.add,
                  onPickEnd: chosen.add,
                ),
              ),
            ),
          ),
        ),
      );
      final slider = tester.getRect(find.byType(Slider));
      final gesture =
          await tester.startGesture(slider.centerLeft.translate(20, 0));
      for (var i = 0; i < 5; i++) {
        await gesture.moveBy(const Offset(30, 0));
        await tester.pump();
      }
      await gesture.up();
      await tester.pump();
      expect(steps.length, greaterThan(1));
      expect(chosen, hasLength(1));
      expect(chosen.single, steps.last);
    });
  });
}
