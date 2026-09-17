import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  final bool isVideoCall;
  const CallScreen({super.key, required this.isVideoCall});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isMuted = false;
  bool isSpeaker = false;
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111C2E),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                SizedBox(height: 50),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF0066FF),
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(height: 15),
                Text(
                  "Calling...",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            
            // Call Action Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          isMuted ? Icons.mic_off : Icons.mic,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () => setState(() => isMuted = !isMuted),
                      ),
                      IconButton(
                        icon: Icon(
                          isSpeaker ? Icons.volume_up : Icons.volume_down,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () => setState(() => isSpeaker = !isSpeaker),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.fiber_manual_record,
                          color: isRecording ? Colors.red : Colors.white,
                          size: 32,
                        ),
                        onPressed: () => setState(() => isRecording = !isRecording),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.call_end, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
