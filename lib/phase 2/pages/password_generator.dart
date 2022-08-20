import 'package:flutter/material.dart';

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneratePass extends StatefulWidget {
  const GeneratePass({Key? key, required String title}) : super(key: key);

  @override
  State<GeneratePass> createState() => _GeneratePassState();
}

class _GeneratePassState extends State<GeneratePass> {
  bool spclch = true;
  bool numbers = true;
  bool upper = true;
  bool lower = true;
  int length = 8;
  double value = 8;
  final ctrlr = TextEditingController();
  final ctrlr1 = TextEditingController();
  @override
  void dispose() {
    ctrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Random Password Generator',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Generated Password',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            TextField(
              controller: ctrlr,
              readOnly: true,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    final copypassword = ClipboardData(text: ctrlr.text);
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
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            buildButton(),
            SizedBox(height: 30, child: buildNum(context)),
            uppercase(),
            lowercase(),
            numcase(),
            specialchrs(),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    var backgroundColor1 = MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.pressed) ? Colors.black : Colors.green);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: backgroundColor1,
      ),
      child: Text(
        'Generate Password',
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () {
        final password = generatePassword(length);
        ctrlr.text = password;
      },
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
              fontSize: 19,
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
        controlAffinity: ListTileControlAffinity.leading,
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
              fontSize: 19,
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
        controlAffinity: ListTileControlAffinity.leading,
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
              fontSize: 19,
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
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  Widget specialchrs() {
    return SizedBox(
      height: 30,
      child: CheckboxListTile(
        title: Text(
          'Special Characters (#\$%^&)',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 19,
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
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
