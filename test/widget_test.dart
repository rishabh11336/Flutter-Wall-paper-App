import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wallpaper_app/app/app.dart';

void main() {
  testWidgets('App boots up successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Wrap WallpaperApp in a ProviderScope since it uses Riverpod.
    await tester.pumpWidget(const ProviderScope(child: WallpaperApp()));

    // Verify that the app title 'WallCraft' is found on the home screen.
    expect(find.text('WallCraft'), findsOneWidget);
  });
}
