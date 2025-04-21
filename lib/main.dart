import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/expense_provider.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Build our custom color scheme from your palette
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF396756),       // mid‑green
      onPrimary: Color(0xFFEEEEEE),     // very light grey for text/icons on primary
      secondary: Color(0xFF204737),     // dark green accent (AppBar)
      onSecondary: Colors.white,        // text/icons on secondary
      background: Color(0xFFF5F3EE),    // cream
      onBackground: Color(0xFF333333),  // charcoal text
      surface: Colors.white,            // cards, sheets
      onSurface: Color(0xFF333333),     // text on surfaces
      error: Colors.red.shade700,
      onError: Colors.white,
    );

    return ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData.from(colorScheme: colorScheme).copyWith(
          scaffoldBackgroundColor: colorScheme.background,
          appBarTheme: AppBarTheme(
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
            elevation: 2,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
