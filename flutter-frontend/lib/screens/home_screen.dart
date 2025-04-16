// Importing Flutter's material design package.
import 'package:flutter/material.dart';

// Importing the other screens to navigate to.
import 'chat_screen.dart';
import 'flights_screen.dart';
import 'hotels_screen.dart';
import 'explore_screen.dart';

// Stateless widget for the home screen of the app.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // A helper method to navigate to a new screen using Flutter's Navigator.
  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen), // Pushes the screen onto the stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with a title and background color.
      appBar: AppBar(
        title: const Text("Travel Assistant"),
        backgroundColor: Colors.deepOrangeAccent,
      ),

      // Body of the screen with a greeting and grid of cards.
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting text at the top with padding.
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Hi there! What would you like to do today?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),

          // Grid layout for the feature cards (Flights, Hotels, Chat, Explore).
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // 2 cards per row
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                // Card to navigate to FlightsScreen
                _buildHomeCard(
                  icon: Icons.flight_takeoff,
                  label: 'Book Flights',
                  onTap: () => navigateTo(context, const FlightsScreen()),
                ),

                // Card to navigate to HotelsScreen
                _buildHomeCard(
                  icon: Icons.hotel,
                  label: 'Find Hotels',
                  onTap: () => navigateTo(context, const HotelsScreen()),
                ),

                // Card to navigate to ChatScreen
                _buildHomeCard(
                  icon: Icons.chat,
                  label: 'Chat Assistant',
                  onTap: () => navigateTo(context, const ChatScreen()),
                ),

                // Card to navigate to ExploreScreen
                _buildHomeCard(
                  icon: Icons.explore,
                  label: 'Explore',
                  onTap: () => navigateTo(context, const ExploreScreen()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // A reusable method to build individual home screen cards.
  Widget _buildHomeCard({
    required IconData icon, // Icon displayed on the card
    required String label,  // Label displayed below the icon
    required VoidCallback onTap, // Function triggered when the card is tapped
  }) {
    return GestureDetector(
      onTap: onTap, // Handles user tap
      child: Card(
        elevation: 4, // Adds shadow
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Rounded corners
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Minimizes space usage
            children: [
              Icon(icon, size: 40, color: Colors.deepOrangeAccent), // Display icon
              const SizedBox(height: 12), // Spacing between icon and label
              Text(label, style: const TextStyle(fontSize: 16)), // Display label
            ],
          ),
        ),
      ),
    );
  }
}
