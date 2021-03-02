import 'package:DevJournal/view/autehntication/parent_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class LoginPage2 extends StatefulWidget {
  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2>
    with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final positionController = TextEditingController();

  AnimationController _controller;
  Animation _animation;
  ScrollPhysics physics = NeverScrollableScrollPhysics();
  final scrollController = ScrollController();
  int currentIndex = 0;
  bool isIgnore = false;

  FocusNode _focusNodeName = FocusNode();
  FocusNode _focusNodePosition = FocusNode();

  void isFocusTrue(FocusNode node) {
    if (node.hasFocus) {
      _controller.forward().whenComplete(() => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          ));
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0, end: 180.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNodeName.addListener(() {
      isFocusTrue(_focusNodeName);
    });

    _focusNodePosition.addListener(() {
      isFocusTrue(_focusNodePosition);
    });

    KeyboardVisibilityNotification().addNewListener(
      onHide: () {
        _focusNodeName.unfocus();
        _focusNodePosition.unfocus();
      },
    );
  }

  Widget formField(TextEditingController controller) => SizedBox(
        height: 55,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(244, 243, 243, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: TextFormField(
                controller: controller,
                focusNode: _focusNodeName,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                    border: InputBorder.none,
                    hintText:
                        controller == nameController ? "Your Name" : "Password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            )),
      );

  Widget formPositionField() {
    return SizedBox(
        height: 55,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Color.fromRGBO(244, 243, 243, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Positioned(
                top: -5,
                right: 10,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      disabledHint: Container(),
                      iconSize: 40,
                      onChanged: (str) {
                        setState(() {
                          positionController.text = str;
                        });
                      },
                      // value: _chosenValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      items: <String>[
                        'To-DO List',
                        'Simple Calculator',
                        'Cashier',
                        'Cartoon List',
                        'Book Store + Library + Trading Book + E-Book Promotion'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                ),
              ),
              // ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: positionController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                          border: InputBorder.none,
                          hintText: "Position",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ParentBackgroundPage(
      controller: scrollController,
      height: _animation.value,
      title: "Login to \nExisting Account",
      swipeTitle: "Swipe up to create a new account",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            formField(nameController),
            formPositionField(),
            nextButton(context),
            SizedBox(
              height: 13,
            ),
            Center(
                child: Text("I forgot my password",
                    style: GoogleFonts.roboto(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(120, 33, 232, 1)))),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}

Widget nextButton(BuildContext context) {
  return Center(
    child: Container(
        height: 40,
        width: (MediaQuery.of(context).size.width / 2) + 50,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 5),
                  // spreadRadius: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.3))
            ],
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Color.fromRGBO(120, 33, 232, 1)),
        child: FlatButton(
          onPressed: () {},
          child: Text("Sing Up",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        )),
  );
}
