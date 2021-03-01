import 'package:DevJournal/view/flutter_otp_field.dart';
import 'package:DevJournal/view/parent_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpPage extends StatefulWidget {
  final Widget child;

  const OtpPage({Key key, this.child}) : super(key: key);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  Widget otpField() {
    return VerificationCode(
        textStyle:
            TextStyle(fontSize: 20, color: Color.fromRGBO(73, 79, 88, 1)),
        underlineColor: Color.fromRGBO(120, 33, 232, 1),
        autofocus: true,
        keyboardType: TextInputType.number,
        length: 6,
        clearAll: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'clear all',
            style: TextStyle(
                fontSize: 14.0,
                decoration: TextDecoration.underline,
                color: Colors.blue[700]),
          ),
        ),
        onCompleted: (String value) {},
        onEditing: (bool value) {});
  }

  @override
  Widget build(BuildContext context) {
    return ParentBackgroundPage(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter OTP",
                style: GoogleFonts.roboto(
                    color: Color.fromRGBO(120, 33, 232, 1),
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300)),
            otpField()
          ],
        ),
      ),
    );
  }
}
