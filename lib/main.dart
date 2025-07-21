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
      title: 'Jay Jhaveri - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color(0xFF4F46E5), // Indigo
          secondary: const Color(0xFF7C3AED), // Purple
          background: Colors.transparent,
          onBackground: Colors.black87,
          surface: Colors.white.withOpacity(0.9),
          onSurface: Colors.black87,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFF6366F1), // Lighter indigo for dark mode
          secondary: const Color(0xFF8B5CF6), // Lighter purple for dark mode
          background: Colors.transparent,
          onBackground: Colors.white70,
          surface: Colors.black.withOpacity(0.3),
          onSurface: Colors.white70,
        ),
      ),
      themeMode: themeMode, // Use the themeMode from the provider
      home: const HomePage(), // HomePage no longer needs toggleTheme callback
    );
  }
}
