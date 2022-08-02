import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager_app/phase%202/pages/add_pass.dart';
import 'package:password_manager_app/phase%202/pages/password_generator.dart';

import 'dashboard.dart';
import 'login.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final editingController = TextEditingController();
  int _selectedIndex = 0;
  static List<Widget> widgetOptions = <Widget>[
    const Dashboard(),
    const GeneratePass(title: 'title'),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Welcome User"),
            ElevatedButton(
              onPressed: () async => {
                await FirebaseAuth.instance.signOut(),
                await signOut123(),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(
                        title: 'title',
                      ),
                    ),
                    (route) => false)
              },
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              child: const Text('Logout'),
            )
          ],
        ),
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.password_outlined, size: 28),
            label: 'Password Generator',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => buildSearch(),
              barrierDismissible: false,
            ),
            child: const Icon(Icons.search),
          ),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.lightGreen,
            foregroundColor: Colors.white,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const AddPass(),
              barrierDismissible: false,
            ),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Future<void> signOut123() async {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
  }

  Widget buildSearch() {
    return TextField(
      controller: editingController,
      decoration: const InputDecoration(
        labelText: "Search",
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
