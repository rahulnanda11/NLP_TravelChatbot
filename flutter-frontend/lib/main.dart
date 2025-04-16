// Importing the Flutter material design package to use UI widgets and themes.
import 'package:flutter/material.dart';

// Importing the home screen of the app from the 'screens' directory.
import 'screens/home_screen.dart';

// Entry point of the Flutter application.
void main() {
  // This function runs the app and starts with the TravelApp widget.
  runApp(const TravelApp());
}

// Defining the main widget of the application, which is stateless.
class TravelApp extends StatelessWidget {
  // Constructor for TravelApp, with optional key.
  const TravelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Returning a MaterialApp widget which sets up the app's visual structure.
    return MaterialApp(
      // Hides the debug banner in the top-right corner.
      debugShowCheckedModeBanner: false,

      // Title of the application.
      title: 'Travel Assistant',

      // Setting the primary color theme for the app.
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),

      // The screen that will be displayed first when the app starts.
      home: const HomeScreen(),
    );
  }
}
