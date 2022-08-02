import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadFromFirestore extends StatefulWidget {
  const ReadFromFirestore({Key? key}) : super(key: key);

  @override
  State<ReadFromFirestore> createState() => _ReadFromFirestoreState();
}

class _ReadFromFirestoreState extends State<ReadFromFirestore> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('All Users'),
        ),
        body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.data}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Waiting');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView(children: users.map(buildUser).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
  Widget buildUser(User user) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(color: Colors.black),
            Text(
              'App Name: ${user.appName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 22,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                'Email: ${user.email}',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                'Password: ${user.password}',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
// Press this button to edit a single product
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                const SizedBox(
                  width: 200,
                ),
                // => _update(documentSnapshot)),
// This icon button is used to delete a single product
                IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
                //  => _deleteProduct(documentSnapshot.id)),
              ],
            ),
            const Divider(color: Colors.black)
          ],
        ),
      );
  // Container(
  //       // padding: const EdgeInsets.all(32),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         // mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Text(
  //             'App Name: ${user.appName}',
  //             style: GoogleFonts.lato(
  //               textStyle: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           Text(
  //             'App Name: ${user.appName}',
  //             style: GoogleFonts.lato(
  //               textStyle: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           Text(
  //             'App Name: ${user.appName}',
  //             style: GoogleFonts.lato(
  //               textStyle: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users123')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  // tempfun() {
  //   var name;
  //   FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       name = value.get('userName');
  //     });
  //   });
  // }
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
