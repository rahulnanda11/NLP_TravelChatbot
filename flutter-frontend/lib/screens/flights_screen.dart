import 'package:flutter/material.dart';

class FlightsScreen extends StatelessWidget {
  const FlightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Flights'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search for Flights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Searching for flights...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
              ),
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Popular Destinations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.flight),
                    title: Text('Chennai → Bangalore'),
                  ),
                  ListTile(
                    leading: Icon(Icons.flight),
                    title: Text('Delhi → Mumbai'),
                  ),
                  ListTile(
                    leading: Icon(Icons.flight),
                    title: Text('Hyderabad → Kochi'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
