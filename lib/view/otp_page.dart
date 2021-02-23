import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController controller = TextEditingController();
  Widget formOtpField() {
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
                hintText: "OTP Code",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [formOtpField()],
        ),
      ),
    );
  }
}
