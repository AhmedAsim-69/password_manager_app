import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:password_manager_app/phase%201/main.dart';
import 'package:password_manager_app/phase%202/pages/login.dart';

import 'auth_service.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  var name = "";
  var email = "";
  var password = "";
  var confirmPassword = "";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  registration() async {
    if (password == confirmPassword) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        snackbar('Registration Successful');
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(title: 'title'),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          snackbar('Please enter a strong password');
        } else if (e.code == 'email-already-in-use') {
          snackbar("Account already exists. Please enter a new email.");
        }
      }
    } else {
      snackbar("Password and Confirm Password doesn't match");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  'Create an account',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
                const SizedBox(
                  height: 70,
                ),
                buildName(),
                buildEmail(),
                buildPass(),
                buildConfirmPass(),
                buildSignupButton(),
                buildAccExist(),
                const SizedBox(
                  height: 30,
                ),
                buildGoogleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Full Name: ',
          labelStyle: const TextStyle(
            fontSize: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 14),
        ),
        controller: nameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your full name';
          }
          return null;
        },
      ),
    );
  }

  Widget buildEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Email: ',
          labelStyle: const TextStyle(
            fontSize: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 14),
        ),
        controller: emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Email';
          } else if (!value.contains('@')) {
            return 'Please Enter Valid Email';
          }
          return null;
        },
      ),
    );
  }

  Widget buildPass() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        obscureText: _obscureText1,
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Password: ',
          labelStyle: const TextStyle(
            fontSize: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 14),
          suffixIcon: IconButton(
              icon: Icon(
                !_obscureText1 ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                setState(() {
                  _obscureText1 = !_obscureText1;
                });
              }),
        ),
        controller: passwordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Password';
          }
          return null;
        },
      ),
    );
  }

  Widget buildConfirmPass() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        obscureText: _obscureText2,
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Confirm Password: ',
          labelStyle: const TextStyle(
            fontSize: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 14),
          suffixIcon: IconButton(
              icon: Icon(
                !_obscureText2 ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                setState(() {
                  _obscureText2 = !_obscureText2;
                });
              }),
        ),
        controller: confirmPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Re-Enter Password';
          }
          return null;
        },
      ),
    );
  }

  Widget buildSignupButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Validate returns true if the form is valid, otherwise false.
            if (_formKey.currentState!.validate()) {
              setState(() {
                email = emailController.text;
                password = passwordController.text;
                confirmPassword = confirmPasswordController.text;
              });
              registration();
            }
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  Widget buildAccExist() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an Account? "),
        TextButton(
            onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const LoginPage(
                        title: 'tile',
                      ),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  )
                },
            child: const Text('Login'))
      ],
    );
  }

  Widget buildGoogleButton() {
    return SignInButton(
      Buttons.Google,
      onPressed: () {
        AuthService().signInWithGoogle();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Logged in successfully",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              textAlign: TextAlign.center,
              textScaleFactor: 1,
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthService().handleAuthState(),
          ),
        );
      },
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(
      String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          msg,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          textAlign: TextAlign.center,
          textScaleFactor: 1,
        ),
      ),
    );
  }
}
