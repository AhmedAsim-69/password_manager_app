// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_manager_app/phase%202/pages/password_generator.dart';

final namectrl = TextEditingController();
final emailctrl = TextEditingController();
final passctrl = TextEditingController();
bool spclch = true;
bool numbers = true;
bool upper = true;
bool lower = true;
int length = 8;
double value = 8;

class NewEditPassDial extends StatefulWidget {
  const NewEditPassDial({Key? key}) : super(key: key);

  @override
  State<NewEditPassDial> createState() => _NewEditPassDialState();
}

class _NewEditPassDialState extends State<NewEditPassDial> {
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
            return 'The App Name cannot be empty';
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

  Widget buildGenPass(TextEditingController ctrl) => Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                final pass = generatePassword(length);
                passctrl.text = pass;
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
          ),
          uppercase(),
          lowercase(),
          numcase(),
          specialchrs(),
          buildNum(context),
        ],
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () {
            final docUser = FirebaseFirestore.instance
                .collection(FirebaseAuth.instance.currentUser!.email!)
                .doc();

            docUser.update(
              {
                'appName': 'Faceboooook',
              },
            );
            // final user = User(
            //     appName: namectrl.text,
            //     email: emailctrl.text,
            //     password: passctrl.text);

            // updatePassToFirestore(user);
            // Navigator.pop(context, true);
            // namectrl.clear();
            // emailctrl.clear();
            // passctrl.clear();
          },
          child: Text(
            'Save Updated Password',
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

  Future updatePassToFirestore(User user) async {
    // return await
  }

  String generatePassword(final length) {
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const nums = '0123456789';
    const specialcharacters = '~!@#\$`%^&*()_+`=,./?<>:"{};';

    String pass = ' ';
    if (lower) pass += lowercase;
    if (upper) pass += uppercase;
    if (numbers) pass += nums;
    if (spclch) pass += specialcharacters;

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(pass.length);

      return pass[indexRandom];
    }).join('');
  }

  Widget uppercase() {
    return SizedBox(
      height: 30,
      child: CheckboxListTile(
        title: Text(
          'Upperacse (ABCD)',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        value: upper,
        onChanged: (newValue) {
          setState(() {
            upper = newValue!;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget lowercase() {
    return SizedBox(
      height: 30,
      child: CheckboxListTile(
        title: Text(
          'LowerCase (abcd)',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        value: lower,
        onChanged: (newValue) {
          setState(() {
            lower = newValue!;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget numcase() {
    return SizedBox(
      height: 30,
      child: CheckboxListTile(
        title: Text(
          'Numbers (0123)',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        value: numbers,
        onChanged: (newValue) {
          setState(() {
            numbers = newValue!;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget specialchrs() {
    return SizedBox(
      height: 50,
      child: CheckboxListTile(
        title: Text(
          'Special Characters (#\$%^&)',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        value: spclch,
        onChanged: (newValue) {
          setState(() {
            spclch = newValue!;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget buildNum(BuildContext context) {
    return Slider(
      value: value,
      min: 8,
      max: 50.0,
      divisions: 42,
      label: "Password Length: ${value.round().toString()}",
      onChanged: (double newValue) {
        setState(
          () {
            value = newValue;
            length = value.toInt();
          },
        );
      },
      activeColor: Colors.green,
      inactiveColor: Colors.black,
    );
  }
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
