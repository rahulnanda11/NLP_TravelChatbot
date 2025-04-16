import 'package:flutter/material.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Hotels'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search for Hotels',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Searching for hotels...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
              ),
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Popular Hotels',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.hotel),
                    title: Text('Leela Palace, Chennai'),
                    subtitle: Text('Luxury Stay'),
                  ),
                  ListTile(
                    leading: Icon(Icons.hotel),
                    title: Text('Taj Lands End, Mumbai'),
                    subtitle: Text('Sea View'),
                  ),
                  ListTile(
                    leading: Icon(Icons.hotel),
                    title: Text('ITC Grand Chola, Chennai'),
                    subtitle: Text('Heritage Luxury'),
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
