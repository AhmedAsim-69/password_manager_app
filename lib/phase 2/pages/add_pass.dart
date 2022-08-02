// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager_app/phase%202/pages/new_pass_dial.dart';

class AddPass extends StatefulWidget {
  const AddPass({Key? key}) : super(key: key);

  @override
  _AddPassState createState() => _AddPassState();
}

class _AddPassState extends State<AddPass> {
  final _formKey = GlobalKey<FormState>();
  String appname = '';
  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a new Password',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.center,
                textScaleFactor: 1,
              ),
              const SizedBox(height: 8),
              const NewPassaDial(),
            ],
          ),
        ),
      );
}
