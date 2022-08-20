import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:password_manager_app/phase%202/pages/edit_pass.dart';

class ReadFromFirestore extends StatefulWidget {
  const ReadFromFirestore({Key? key}) : super(key: key);

  @override
  State<ReadFromFirestore> createState() => _ReadFromFirestoreState();
}

class _ReadFromFirestoreState extends State<ReadFromFirestore> {
  final user = FirebaseAuth.instance.currentUser;
  String appname = '';
  String email = '';
  String pass = '';
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.data}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Waiting');
            }
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final users = snapshot.data!;
                return ListView(children: users.map(buildUser).toList());
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Text("Working to get data");
          },
        ),
      );
  Widget buildUser(User user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Colors.black),
          Row(
            children: [
              Text(
                'App Name: ${user.appName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  final copypassword = ClipboardData(text: user.appName);
                  Clipboard.setData(copypassword);

                  SnackBar snackBar = SnackBar(
                    content: Text(
                      'App Name copied to clipboard',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Email: ${user.email}',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  final copypassword = ClipboardData(text: user.email);
                  Clipboard.setData(copypassword);

                  SnackBar snackBar = SnackBar(
                    content: Text(
                      'Email copied to clipboard',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Password: **********",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  final copypassword = ClipboardData(text: user.password);
                  Clipboard.setData(copypassword);

                  SnackBar snackBar = SnackBar(
                    content: Text(
                      'Password copied to clipboard',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => EditPass(
                          userid: user.id,
                          userapp: user.appName,
                          useremail: user.email,
                          userpass: user.password),
                    );
                  }),
              const SizedBox(
                width: 200,
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Delete Password!"),
                        content: const Text(
                            "Are you sure you want to delete this Password?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              final docUser = FirebaseFirestore.instance
                                  .collection(
                                      FirebaseAuth.instance.currentUser!.email!)
                                  .doc(user.id);

                              docUser.delete();
                              Navigator.pop(context, true);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
          const Divider(color: Colors.black)
        ],
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email!)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

class User {
  String id;
  final String appName;
  final String email;
  final String password;

  User({
    this.id = '',
    required this.appName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'appName': appName,
        'email': email,
        'password': password,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        appName: json['appName'],
        email: json['email'],
        password: json['password'],
      );
}
