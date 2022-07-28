import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager_app/phase 2/pages/signup.dart';
import 'forgot_pass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required String title}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

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
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ListView(
              shrinkWrap: true,
              children: [
                buildEmail(),
                buildPass(),
                buildLoginButton(),
                buildSignupButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        autofocus: false,
        decoration: const InputDecoration(
          labelText: 'Email: ',
          labelStyle: TextStyle(fontSize: 20.0),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: OutlineInputBorder(),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
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
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password: ',
          labelStyle: TextStyle(fontSize: 20.0),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: OutlineInputBorder(),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
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
              }
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
                  builder: (context) => ForgotPassword(),
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
                pageBuilder: (context, a, b) => Signup(),
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
}
