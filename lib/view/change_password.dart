import 'package:flutter/material.dart';

class OtpChangePassword extends StatelessWidget {
  final controller = TextEditingController();
  Widget formField() {
    return Container(
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
                // prefixIcon: Icon(
                //   controller == emailController
                //       ? Icons.people_alt_rounded
                //       : Icons.lock_outlined,
                //   color: Colors.black87,
                // ),
                hintText: "Enter Otp",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Please check your emai. \nWe have sent OTP code to your email."),
            formField(),
            
          ],
        ),
      ),
    );
  }
}

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final newPassController = TextEditingController();
  final confirmController = TextEditingController();

  Widget formField(TextEditingController controller) {
    String check = controller == newPassController
        ? "New Password"
        : "Confirm New Password";
    return Container(
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
                // prefixIcon: Icon(
                //   controller == emailController
                //       ? Icons.people_alt_rounded
                //       : Icons.lock_outlined,
                //   color: Colors.black87,
                // ),
                hintText: check,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Change Password"),
            formField(newPassController),
            formField(confirmController)
          ],
        ),
      ),
    );
  }
}
