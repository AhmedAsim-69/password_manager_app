import 'package:flutter/material.dart';
import 'package:password_manager_app/phase%202/pages/read_from_firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const ReadFromFirestore();
  }
}
