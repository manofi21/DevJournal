import 'package:DevJournal/view/flutter_otp_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentBackgroundPage extends StatefulWidget {
  final Widget child;
  final double height;
  final String title;
  final ScrollController controller;
  final String swipeTitle;
  final Function swipeNavigatorFunction;

  const ParentBackgroundPage(
      {Key key,
      this.child,
      this.height,
      this.controller,
      this.title,
      this.swipeTitle,
      this.swipeNavigatorFunction})
      : super(key: key);
  @override
  _ParentBackgroundPageState createState() => _ParentBackgroundPageState();
}

class _ParentBackgroundPageState extends State<ParentBackgroundPage> {
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.85,
                  child: Stack(
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
                            Text("Welcome to",
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
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2.3,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(widget.title,
                              style: GoogleFonts.roboto(
                                  color: Color.fromRGBO(120, 33, 232, 1),
                                  fontSize: 30,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700)),
                        ),
                      )
                    ],
                  ),
                ),
                widget.child,
                (widget.swipeTitle == null)
                    ? Container()
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(
                              child: Text(widget.swipeTitle,
                                  style: GoogleFonts.roboto(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(120, 33, 232, 1)))),
                          SizedBox(
                            height: widget.height,
                          ),
                          Center(
                            child: Image.asset(
                              "assets/Ellipse 7.png",
                              scale: 1,
                            ),
                          ),
                        ],
                      ),

                // Spacer()
              ],
            ),
          ),
        ));
  }
}
