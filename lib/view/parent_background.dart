import 'package:DevJournal/view/flutter_otp_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentBackgroundPage extends StatefulWidget {
  final Widget child;
  final double height;
  final ScrollController controller;

  const ParentBackgroundPage({Key key, this.child, this.height, this.controller})
      : super(key: key);
  @override
  _ParentBackgroundPageState createState() => _ParentBackgroundPageState();
}

class _ParentBackgroundPageState extends State<ParentBackgroundPage> {
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
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color.fromRGBO(129, 169, 182, 1)),
          child: SingleChildScrollView(
            controller: widget.controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(129, 169, 182, 1)),
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/header_background.png"),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 4.8,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcomo to",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w300)),
                          Text("DevJurnal",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
                widget.child,
                SizedBox(
                  height: widget.height,
                )
                // Spacer()
              ],
            ),
          ),
        ));
  }
}
