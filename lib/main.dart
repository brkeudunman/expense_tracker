import 'package:expense_tracker/screens/home.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue.shade200);

void main() {
  runApp(
    MaterialApp(
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.blue.shade50,
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.all(12),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            elevation: 2,
            shadowColor: kColorScheme.primaryContainer,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                side: BorderSide(
                  width: 0.5,
                  color: kColorScheme.primaryContainer,
                ),
              ),
            ),
          ),
          textTheme: const TextTheme().copyWith(
            titleLarge: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(
              color: kColorScheme.onPrimaryContainer,
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kColorScheme.onPrimaryContainer,
            )
          ),
        ),
        home: const HomeScreen()),
  );
}
