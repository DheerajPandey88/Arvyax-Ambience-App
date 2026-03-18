import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/ambience/ambience_screen.dart';
import 'package:arvyax_application/features/ambience/player/player_controller.dart';
import 'package:arvyax_application/features/ambience/journal/journal_controller.dart';
import 'shared/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerController()),
        ChangeNotifierProvider(create: (_) => JournalController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const AmbienceScreen(),
      ),
    );
  }
}