import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainPage(title: 'Pass App'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required String title}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          'Upper Case Chaarcters',
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
          'Lower Case Chaarcters',
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
          'Numbers',
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
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Widget specialchrs() {
    return SizedBox(
      height: 30,
      child: CheckboxListTile(
        title: Text(
          'Special Characters',
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
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }
}
