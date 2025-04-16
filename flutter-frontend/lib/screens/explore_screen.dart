import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  final List<Map<String, String>> destinations = const [
    {
      'title': 'Goa',
      'subtitle': 'Beaches & Parties',
      'image': 'https://picsum.photos/id/1015/400/200',
    },
    {
      'title': 'Manali',
      'subtitle': 'Snowy Mountains',
      'image': 'https://picsum.photos/id/1003/400/200',
    },
    {
      'title': 'Kerala',
      'subtitle': 'Backwaters & Nature',
      'image': 'https://picsum.photos/id/1020/400/200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Destinations'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final place = destinations[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    place['image']!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place['title']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(place['subtitle']!),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
