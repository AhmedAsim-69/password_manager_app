import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager_app/phase%202/pages/new_pass_dial.dart';

class AddPass extends StatefulWidget {
  const AddPass({Key? key}) : super(key: key);

  @override
  AddPassState createState() => AddPassState();
}

class AddPassState extends State<AddPass> {
  final _formKey = GlobalKey<FormState>();
  String appname = '';
  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: AlertDialog(
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
        ),
      );
}
