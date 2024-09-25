import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prak3/sidemenu.dart';

class HomePage extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  const HomePage({super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page - Welcome $username'),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: (value) {
              widget.toggleTheme(value);
            },
            activeTrackColor: Colors.yellow,
            activeColor: Colors.orangeAccent,
          )
        ],
      ),
      drawer: const Sidemenu(),
      body: Center(
        child: Text(
          'Hello, $username! Welcome to your dashboard.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
