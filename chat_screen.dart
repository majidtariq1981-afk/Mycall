import 'package:flutter/material.dart';

class ChatScreenUI extends StatefulWidget {
  final String userName;
  const ChatScreenUI({super.key, required this.userName});

  @override
  State<ChatScreenUI> createState() => _ChatScreenUIState();
}

class _ChatScreenUIState extends State<ChatScreenUI> {
  final List<String> messages = ["Hello!", "Welcome to Mycall app!"];
  final TextEditingController _msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        backgroundColor: const Color(0xFF0066FF),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isMe = index % 2 == 0;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFF0066FF) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      messages[index],
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Input Bar (Text Input & Voice Note)
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.mic, color: Color(0xFF0066FF)),
                  onPressed: () {
                    // Audio Record Logic
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF0066FF)),
                  onPressed: () {
                    if (_msgController.text.isNotEmpty) {
                      setState(() {
                        messages.add(_msgController.text);
                      });
                      _msgController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
