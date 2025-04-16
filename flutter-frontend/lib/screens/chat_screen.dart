// Import necessary packages
import 'dart:convert';                      // For encoding and decoding JSON
import 'package:flutter/material.dart';     // Flutter UI package
import 'package:http/http.dart' as http;    // For making HTTP requests

// Message model to hold chat message text and who sent it (user or bot)
class Message {
  final String text;
  final bool isUser;
  Message({required this.text, required this.isUser});
}

// Chat screen widget that maintains state
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = []; // List to store chat messages
  final TextEditingController _controller = TextEditingController(); // Controller for input field

  // Method to send message to Rasa backend and handle response
  void sendMessage(String text) async {
    if (text.trim().isEmpty) return; // Ignore empty messages

    // Add user's message to chat list
    setState(() {
      messages.add(Message(text: text, isUser: true));
    });

    _controller.clear(); // Clear input field

    // Make POST request to Rasa REST webhook
    final response = await http.post(
      Uri.parse('http://192.168.189.76:5005/webhooks/rest/webhook'), // Rasa backend URL for Android emulator
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'sender': 'user', 'message': text}),
    );

    // Handle bot response
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      for (var msg in data) {
        if (msg.containsKey('text')) {
          setState(() {
            messages.add(Message(text: msg['text'], isUser: false));
          });
        }
      }
    } else {
      // In case of failure, show error message
      setState(() {
        messages.add(Message(
          text: "Oops! Failed to get a response from the bot.",
          isUser: false,
        ));
      });
    }
  }

  // Builds a single chat message widget (user or bot)
  Widget buildMessage(Message msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Row(
          mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bot avatar on the left
            if (!msg.isUser)
              const CircleAvatar(
                backgroundImage: AssetImage('assets/bot_avatar.png'),
                radius: 16,
              ),
            if (!msg.isUser) const SizedBox(width: 8),

            // Chat bubble
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: msg.isUser ? Colors.orange[100] : Colors.lightBlue[100], // Different colors for user/bot
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  msg.text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            if (msg.isUser) const SizedBox(width: 8),

            // User avatar on the right
            if (msg.isUser)
              const CircleAvatar(
                backgroundImage: AssetImage('assets/user_avatar.png'),
                radius: 16,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Light background color
      appBar: AppBar(
        title: const Text("Travel Chatbot"),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Message list
          Expanded(
            child: ListView.builder(
              reverse: false, // Messages flow from top to bottom
              itemCount: messages.length,
              itemBuilder: (_, index) => buildMessage(messages[index]),
            ),
          ),

          // Input field and send button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask me about flights, hotels, or more...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: sendMessage, // Send on enter
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepOrangeAccent),
                  onPressed: () => sendMessage(_controller.text), // Send on tap
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
