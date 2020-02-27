import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniturestreet/main.dart';
import 'package:furniturestreet/shared/style.dart';
import 'package:http/http.dart' as http;

class OtpPanel extends StatefulWidget {
  final String mobile;

  const OtpPanel({Key key, this.mobile}) : super(key: key);
  @override
  _OtpPanelState createState() => _OtpPanelState();
}

class _OtpPanelState extends State<OtpPanel> {
  TextEditingController otpController = TextEditingController();
  Map otpResponse;
  Future sendOtp() async {
    http.Response response = await http.post(
        "https://furniturestreet.in/MobileApi/users/send_otp",
        body: {"mobile": widget.mobile});
    setState(() {
      otpResponse = json.decode(response.body);
    });
  }

  bool otpTapped = false;
  @override
  void initState() {
    sendOtp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Text(
              'We have sent an OTP to verify your mobile number',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20, top: 20),
            child: Container(
              color: Colors.grey[200],
              child: TextFormField(
                controller: otpController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  otpTapped = true;
                });

                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Homepage()));
              },
              child: Container(
                color: primary,
                width: 200,
                height: 40,
                child: otpTapped
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: Text(
                        'Verify',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
