import 'package:DevJournal/view/parent_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_widget/motion_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final pageController = PageController();

  AnimationController _controller;
  Animation _animation;
  ScrollPhysics physics = NeverScrollableScrollPhysics();
  List<Widget> _lWidget = List();
  final scrollController = ScrollController();
  int currentIndex = 0;
  bool isIgnore = false;

  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 50.0, end: 300.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      } else {
        _controller.reverse();
      }
    });
  }

  Widget formField(TextEditingController controller) => SizedBox(
        height: 55,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            // padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromRGBO(244, 243, 243, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: TextFormField(
                controller: controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                    border: InputBorder.none,
                    hintText: controller == emailController
                        ? "Email Address"
                        : "Password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            )),
      );

  @override
  Widget build(BuildContext context) {
    return ParentBackgroundPage(
      controller: scrollController,
      height: _animation.value,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Login to \nExisting Account",
                style: GoogleFonts.roboto(
                    color: Color.fromRGBO(120, 33, 232, 1),
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 10),
            formField(emailController),
            formField(passwordController)
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Column(
    //     children: [
    //       Text("Wellcome to Dev Journal"),
    //       SizedBox(height: 40),
    //       Text("Sign In"),
    //       SizedBox(height: 80),
    //       SizedBox(
    //         height: 100,
    //         child: (IgnorePointer(
    //           ignoring: isIgnore,
    //           child: PageView.builder(
    //               physics: ScrollPhysics(),
    //               controller: pageController,
    //               itemCount: _lWidget.length,
    //               itemBuilder: (context, index) => _lWidget[index]),
    //         )),
    //       ),
    //       RaisedButton(onPressed: () async {
    //         print(_lWidget.length);
    //         if (_lWidget.length == 1 && currentIndex == 0) {
    //           _lWidget.add(formField(passwordController));
    //           setState(() {
    //             isIgnore = true;
    //           });
    //           // final check = await pageController.nextPage(
    //           //     duration: Duration(seconds: 1), curve: Curves.ease);
    //           final check = await pageController.animateToPage(1,
    //               duration: Duration(seconds: 1), curve: Curves.ease);
    //           setState(() {
    //             isIgnore = false;
    //           }); // .then((val) =>
    //           _lWidget.removeAt(0);
    //         }
    //       })
    //     ],
    //   ),
    // );
  }
}
