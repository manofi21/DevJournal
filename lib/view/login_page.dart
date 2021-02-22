import 'package:flutter/material.dart';
import 'package:motion_widget/motion_widget.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
//   // MotionExitConfigurations motionExitConfigurations;
//   AnimationController _controller;
//   CurvedAnimation _animation;
//   @override
//   void initState() {
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 1))
//           ..addListener(() {
//             setState(() {});
//           });
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();
//     final pageController = PageController();

//     ScrollPhysics physics = NeverScrollableScrollPhysics();

//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Text("Wellcome to Dev Journal"),
//           SizedBox(height: 40),
//           Text("Sign In"),
//           SizedBox(height: 80),
//           SizedBox(
//               height: 90,
//               child: Stack(children: <Widget>[
//                 SizedBox(
//                   height: 90,
//                   child: Container(
//                       margin:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                       decoration: BoxDecoration(
//                           color: Color.fromRGBO(244, 243, 243, 1),
//                           borderRadius: BorderRadius.circular(15)),
//                       child: Center(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                               border: InputBorder.none,
//                               prefixIcon: Icon(
//                                 Icons.people_alt_rounded,
//                                 color: Colors.black87,
//                               ),
//                               hintText: "Enter The Email",
//                               hintStyle:
//                                   TextStyle(color: Colors.grey, fontSize: 15)),
//                         ),
//                       )),
//                 )
//               ])),
//           RaisedButton(onPressed: () {
//             // (pageController.page == 0 && pageController.page < 1)
//             //     ? pageController.nextPage(
//             //         duration: Duration(seconds: 1), curve: Curves.ease)
//             //     : pageController.previousPage(
//             //         duration: Duration(seconds: 1), curve: Curves.ease);
//           })
//         ],
//       ),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final pageController = PageController();

  ScrollPhysics physics = NeverScrollableScrollPhysics();
  List<Widget> _lWidget = List();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _lWidget.add(formField(emailController));
  }

  Widget formField(TextEditingController controller) => Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      // padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Color.fromRGBO(244, 243, 243, 1),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                controller == emailController
                    ? Icons.people_alt_rounded
                    : Icons.lock_outlined,
                color: Colors.black87,
              ),
              hintText: controller == emailController
                  ? "Enter The Email"
                  : "Enter The Password",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Wellcome to Dev Journal"),
          SizedBox(height: 40),
          Text("Sign In"),
          SizedBox(height: 80),
          SizedBox(
            height: 100,
            child: PageView.builder(
                controller: pageController,
                itemCount: _lWidget.length,
                itemBuilder: (context, index) => _lWidget[index]),
          ),
          RaisedButton(onPressed: () {
            print(_lWidget.length);
            setState(() {
              if (_lWidget.length == 1 && currentIndex == 0) {
                  _lWidget.add(formField(passwordController));
                  currentIndex = 1;
                  pageController
                      .nextPage(
                          duration: Duration(seconds: 1), curve: Curves.ease)
                      .then((val) => _lWidget.removeAt(0));
                }
              //    else if (_lWidget.length == 1 && currentIndex == 1) {

              // }
            });
            // (pageController.page == 0 && pageController.page < 1)
            //     ?
            //     : pageController.previousPage(
            //         duration: Duration(seconds: 1), curve: Curves.ease);
          })
        ],
      ),
    );
    // body: SizedBox(
    //   height: 100,
    //   child: IgnorePointer(
    //       ignoring: true,
    //       child: PageView.builder(
    //           controller: pageController,
    //           itemCount: 2,
    //           itemBuilder: (context, index) {
    //             if (index == 0) {
    //               return Container(
    //                   margin:
    //                       EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    //                   // padding: EdgeInsets.all(5),
    //                   decoration: BoxDecoration(
    //                       color: Color.fromRGBO(244, 243, 243, 1),
    //                       borderRadius: BorderRadius.circular(15)),
    //                   child: Center(
    //                     child: TextFormField(
    //                       controller: emailController,
    //                       decoration: InputDecoration(
    //                           border: InputBorder.none,
    //                           prefixIcon: Icon(
    //                             Icons.people_alt_rounded,
    //                             color: Colors.black87,
    //                           ),
    //                           hintText: "Enter The Email",
    //                           hintStyle: TextStyle(
    //                               color: Colors.grey, fontSize: 15)),
    //                     ),
    //                   ));
    //             } else {
    //               return TextFormField(
    //                 controller: passwordController,
    //               );
    //             }
    //           })),
    // ),
  }
}
