import 'package:flutter/material.dart';
import 'package:motion_widget/motion_widget.dart';

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
  bool isIgnore = false;

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
            child: (IgnorePointer(
              ignoring: isIgnore,
              child: PageView.builder(
                  physics: ScrollPhysics(),
                  controller: pageController,
                  itemCount: _lWidget.length,
                  itemBuilder: (context, index) => _lWidget[index]),
            )),
          ),
          RaisedButton(onPressed: () async {
            print(_lWidget.length);
            if (_lWidget.length == 1 && currentIndex == 0) {
              _lWidget.add(formField(passwordController));
              setState(() {
                isIgnore = true;
              });
              // final check = await pageController.nextPage(
              //     duration: Duration(seconds: 1), curve: Curves.ease);
              final check = await pageController.animateToPage(1,
                  duration: Duration(seconds: 1), curve: Curves.ease);
              setState(() {
                isIgnore = false;
              }); // .then((val) =>
              _lWidget.removeAt(0);
            }
          })
        ],
      ),
    );
  }
}
