// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_manager_app/phase%202/pages/password_generator.dart';

final namectrl = TextEditingController();
final emailctrl = TextEditingController();
final passctrl = TextEditingController();

class NewPassaDial extends StatefulWidget {
  const NewPassaDial({Key? key}) : super(key: key);

  @override
  State<NewPassaDial> createState() => _NewPassaDialState();
}

class _NewPassaDialState extends State<NewPassaDial> {
  // String title = '';
  // String appName = '';
  // String email = '';
  // String Pass = '';

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildAppName(),
            const SizedBox(height: 8),
            buildEmail(),
            const SizedBox(height: 16),
            buildPass(),
            const SizedBox(height: 16),
            Column(
              children: [
                buildGenPass(passctrl),
                buildButton(),
              ],
            ),
          ],
        ),
      );

  Widget buildAppName() => TextFormField(
        controller: namectrl,
        maxLines: 1,
        validator: (title) {
          if (title!.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter App Name',
        ),
      );

  Widget buildEmail() => TextFormField(
        controller: emailctrl,
        maxLines: 1,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter Username/Email',
        ),
      );

  Widget buildPass() => TextFormField(
        controller: passctrl,
        maxLines: 1,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Enter Password',
        ),
      );
  Widget buildGenPass(TextEditingController ctrl) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () {
            const GeneratePass(
              title: 'title',
            );
          },
          child: Text(
            'Generate Password',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
      );
  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () {
            final user = User(
                appName: namectrl.text,
                email: emailctrl.text,
                password: passctrl.text);

            savePassToFirestore(user);
            Navigator.pop(context, true);
            namectrl.clear();
            emailctrl.clear();
            passctrl.clear();
          },
          child: Text(
            'Save Password',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
      );

  Future savePassToFirestore(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users123').doc();
    user.id = docUser.id;

    // final user = User(
    //   id: docUser.id,
    //   AppName: AppName,
    //   Email: Email,
    //   Password: Pass,
    // );
    final json = user.toJson();
    await docUser.set(json);
  }

  // Stream<List<User>> readUsers() => FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

class User {
  String id;
  String appName = '';
  String email = '';
  String password = '';

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
