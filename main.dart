import 'package:flutter/material.dart';

void main() {
  runApp(const MyCallApp());
}

class MyCallApp extends StatelessWidget {
  const MyCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mycall',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0066FF),
        scaffoldBackgroundColor: const Color(0xFFF4F7FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0066FF),
          foregroundColor: Colors.white,
        ),
      ),
      home: const OTPScreen(),
    );
  }
}

// 1. OTP Sign-In / Registration Screen
class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool isOTPSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mycall - Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone_android, size: 80, color: Color(0xFF0066FF)),
            const SizedBox(height: 20),
            if (!isOTPSent) ...[
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () => setState(() => isOTPSent = true),
                child: const Text("Send OTP", style: TextStyle(color: Colors.white)),
              ),
            ] else ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter 6-digit OTP",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text("Verify & Login", style: TextStyle(color: Colors.white)),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

// 2. Main Dashboard (Dialer, Contacts, Chats)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String searchQuery = "";

  final List<Map<String, String>> contacts = [
    {"name": "Ali Raza", "phone": "+92 300 1234567"},
    {"name": "Usman Khan", "phone": "+92 321 9876543"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mycall")),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildDialer(),
          _buildContactsList(),
          _buildChatList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF0066FF),
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dialpad), label: "Dialer"),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "Contacts"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
        ],
      ),
    );
  }

  Widget _buildDialer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("03001234567", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.call, size: 40, color: Colors.green),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.videocam, size: 40, color: Color(0xFF0066FF)),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  Widget _buildContactsList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (val) => setState(() => searchQuery = val),
            decoration: const InputDecoration(
              hintText: "Search Contact...",
              prefixIcon: Icon(Icons.search, color: Color(0xFF0066FF)),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, i) => ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF0066FF),
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(contacts[i]["name"]!),
              subtitle: Text(contacts[i]["phone"]!),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, i) => ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF0066FF),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(contacts[i]["name"]!),
        subtitle: const Text("Tap to open chat"),
      ),
    );
  }
}
