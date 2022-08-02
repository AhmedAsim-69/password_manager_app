import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager_app/phase 2/pages/signup.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:password_manager_app/phase%202/pages/auth_service.dart';
import 'package:password_manager_app/phase%202/pages/homepage.dart';
import 'forgot_pass.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required String title}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  'Login to Password Manager',
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
                buildEmail(),
                buildPass(),
                const SizedBox(
                  height: 10,
                ),
                buildLoginButton(),
                const SizedBox(
                  height: 10,
                ),
                buildSignupButton(),
                const SizedBox(
                  height: 50,
                ),
                buildGoogleLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Email: ',
          labelStyle: const TextStyle(fontSize: 18, color: Colors.green),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(15),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 15),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(30),
          ),
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
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Password: ',
          labelStyle: const TextStyle(fontSize: 18, color: Colors.green),
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
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 15),
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

  Widget buildLoginButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  email = emailController.text;
                  password = passwordController.text;
                });
                userLogin();
              }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const Homepage(),
              //   ),
              // );
            },
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPassword(),
                ),
              )
            },
            child: const Text(
              'Forgot Password ?',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignupButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Don\'t have an account',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () => {
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (context, a, b) => const Signup(),
                transitionDuration: const Duration(seconds: 0),
              ),
              (route) => false,
            ),
          },
          child: const Text('Signup'),
        ),
      ],
    );
  }

  Widget buildGoogleLogin() {
    return SignInButton(
      Buttons.Google,
      onPressed: () {
        AuthService().signInWithGoogle();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthService().handleAuthState(),
          ),
        );
      },
    );
  }
}
