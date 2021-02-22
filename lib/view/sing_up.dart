import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final otpController = TextEditingController();
  final pageController = PageController();

  ScrollPhysics physics = NeverScrollableScrollPhysics();
  List<Widget> _lWidget = List();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _lWidget.add(Column(
      children: [formField(nameController), formField(positionController)],
    ));
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
                controller == nameController
                    ? Icons.people_alt_rounded
                    : controller == positionController
                        ? Icons.lock_outlined
                        : Icons.phone_callback_outlined,
                color: Colors.black87,
              ),
              hintText: controller == nameController
                  ? "Enter The Name"
                  : controller == positionController
                      ? "Enter The Position"
                      : "Enter The Otp",
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
          Text("Sign Up"),
          SizedBox(height: 80),
          SizedBox(
            height: 200,
            child: PageView.builder(
                controller: pageController,
                itemCount: _lWidget.length,
                itemBuilder: (context, index) => _lWidget[index]),
          ),
          RaisedButton(onPressed: () {
            print(_lWidget.length);
            setState(() {
              if (_lWidget.length == 1 && currentIndex == 0) {
                _lWidget.add(Container(
                    margin: EdgeInsets.symmetric(vertical: 60),
                    child: formField(otpController)));
                currentIndex = 1;
                pageController.nextPage(
                    duration: Duration(seconds: 1), curve: Curves.ease);
                //     .then((val) => _lWidget.removeAt(0));
              }
            });
          })
        ],
      ),
    );
  }
}