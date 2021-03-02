import 'package:DevJournal/view/autehntication/parent_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  AnimationController _controller;
  Animation _animation;
  final scrollController = ScrollController();

  FocusNode _focusNodeName = FocusNode();
  FocusNode _focusNodeEmail = FocusNode();
  FocusNode _focusNodePass = FocusNode();

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
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0.0, end: 200.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNodeName.addListener(() {
      isFocusTrue(_focusNodeName);
    });

    _focusNodeEmail.addListener(() {
      isFocusTrue(_focusNodeEmail);
    });

    _focusNodePass.addListener(() {
      isFocusTrue(_focusNodePass);
    });

    KeyboardVisibilityNotification().addNewListener(
      onHide: () {
        _focusNodeName.unfocus();
        _focusNodeEmail.unfocus();
        _focusNodePass.unfocus();
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
                focusNode: controller == emailController
                    ? _focusNodeEmail
                    : controller == passwordController
                        ? _focusNodePass
                        : _focusNodeName,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                    border: InputBorder.none,
                    hintText: controller == emailController
                        ? "Email Address"
                        : controller == passwordController
                            ? "Password"
                            : "Name",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            )),
      );

  @override
  Widget build(BuildContext context) {
    return ParentBackgroundPage(
      controller: scrollController,
      height: _animation.value,
      title: "Create an \nAccount",
      swipeTitle: "Swipe up to sign in",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            formField(nameController),
            formField(emailController),
            formField(passwordController),
            SizedBox(height: 10),
            nextButton(context),
            // Spacer(),
            SizedBox(
              height: 34,
            ),
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
          child: Text("Next",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        )),
  );
}

//  {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passController = TextEditingController();
//   final positionController = TextEditingController();
//   final otpController = TextEditingController();
//   final pageController = PageController();

//   ScrollPhysics physics = NeverScrollableScrollPhysics();
//   List<Widget> _lWidget = List();
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _lWidget.add(Column(
//       children: [
//         Column(
//           children: [
//             formField(nameController),
//             formField(emailController),
//             formField(passController),
//           ],
//         ),
//         formField(positionController)
//       ],
//     ));
//   }

//   Widget formField(TextEditingController controller) => Container(
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       // padding: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//           color: Color.fromRGBO(244, 243, 243, 1),
//           borderRadius: BorderRadius.circular(15)),
//       child: Center(
//         child: TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//               border: InputBorder.none,
//               prefixIcon: Icon(
//                 controller == nameController
//                     ? Icons.people_alt_rounded
//                     : controller == positionController
//                         ? Icons.lock_outlined
//                         : Icons.phone_callback_outlined,
//                 color: Colors.black87,
//               ),
//               hintText: controller == nameController
//                   ? "Name"
//                   : controller == emailController
//                       ? "Email Address"
//                       : "Password",
//               hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
//         ),
//       ));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Text("Wellcome to Dev Journal"),
//           SizedBox(height: 40),
//           Text("Sign Up"),
//           SizedBox(height: 80),
//           Column(
//             children: [
//               formField(nameController),
//               formField(emailController),
//               formField(passController),
//             ],
//           ),
//           RaisedButton(onPressed: () {
//             print(_lWidget.length);
//             setState(() {
//               if (_lWidget.length == 1 && currentIndex == 0) {
//                 _lWidget.add(Container(
//                     margin: EdgeInsets.symmetric(vertical: 60),
//                     child: formField(otpController)));
//                 currentIndex = 1;
//                 pageController.nextPage(
//                     duration: Duration(seconds: 1), curve: Curves.ease);
//               }
//             });
//           })
//         ],
//       ),
//     );
//   }
// }

// /*
//           SizedBox(
//             height: 200,
//             child: PageView.builder(
//                 controller: pageController,
//                 itemCount: _lWidget.length,
//                 itemBuilder: (context, index) => _lWidget[index]),
//           ),
// */
