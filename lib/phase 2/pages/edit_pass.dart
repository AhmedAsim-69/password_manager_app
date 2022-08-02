// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager_app/phase%202/pages/edit_pass_dial.dart';

class EditPass extends StatefulWidget {
  const EditPass({Key? key}) : super(key: key);

  @override
  _EditPassState createState() => _EditPassState();
}

class _EditPassState extends State<EditPass> {
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
                'Edit Saved Password',
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
              const NewEditPassDial(),
            ],
          ),
        ),
      );
}
