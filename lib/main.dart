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

class MyApp extends ConsumerWidget { // Use ConsumerWidget to access providers
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Add WidgetRef to build method
    final themeMode = ref.watch(themeModeProvider); // Watch the themeModeProvider

    return MaterialApp(
      title: 'Dimas Arya Murdiyan - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ).copyWith(
          secondary: Colors.lightBlueAccent,
          background: Colors.grey[100],
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
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[900],
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.blueGrey[800],
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ).copyWith(
          secondary: Colors.cyan,
          background: Colors.grey[900],
          onBackground: Colors.white70,
          surface: Colors.blueGrey[800],
          onSurface: Colors.white70,
          onSurfaceVariant: Colors.grey[400],
          primaryContainer: Colors.blue.shade900,
          onPrimaryContainer: Colors.blue.shade100,
          secondaryContainer: Colors.cyan.shade900,
          onSecondaryContainer: Colors.cyan.shade100,
          tertiaryContainer: Colors.green.shade900,
          onTertiaryContainer: Colors.green.shade100,
        ),
      ),
      themeMode: themeMode, // Use the themeMode from the provider
      home: const HomePage(), // HomePage no longer needs toggleTheme callback
    );
  }
}
