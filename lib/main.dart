import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ─── Phase 3: Initialise Hive for local favourites storage ──────────
  await Hive.initFlutter();
  await Hive.openBox<String>('favourites');

  runApp(
    const ProviderScope(
      child: WallpaperApp(),
    ),
  );
}
