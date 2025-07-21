import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/presentation/home_page.dart';
import 'package:portfolio/presentation/providers/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Dimas Arya Murdiyan - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.grey[50], // Lighter background
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[50], // Match scaffold background
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ).copyWith(
          secondary: Colors.lightBlueAccent,
          background: Colors.grey[50],
          onBackground: Colors.black87,
          surface: Colors.white,
          onSurface: Colors.black87,
          onSurfaceVariant: Colors.grey[700],
          primaryContainer: Colors.blue.shade100,
          onPrimaryContainer: Colors.blue.shade900,
          secondaryContainer: Colors.lightBlueAccent.shade100,
          onSecondaryContainer: Colors.lightBlueAccent.shade700,
          tertiaryContainer: Colors.green.shade100,
          onTertiaryContainer: Colors.green.shade900,
          surfaceVariant: Colors.grey[200], // For placeholder image background
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.grey[900], // Darker background
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900], // Match scaffold background
          foregroundColor: Colors.white70,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.blueGrey[800],
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ).copyWith(
          secondary: Colors.cyan,
          surface: Colors.blueGrey[800],
          onSurface: Colors.white70,
          onSurfaceVariant: Colors.grey[400],
          primaryContainer: Colors.blue.shade900,
          onPrimaryContainer: Colors.blue.shade100,
          secondaryContainer: Colors.cyan.shade900,
          onSecondaryContainer: Colors.cyan.shade100,
          tertiaryContainer: Colors.green.shade900,
          onTertiaryContainer: Colors.green.shade100,
          surfaceContainerHighest: Colors.blueGrey[700], // For placeholder image background
        ),
      ),
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
