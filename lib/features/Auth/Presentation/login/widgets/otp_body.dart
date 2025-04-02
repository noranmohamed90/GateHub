import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/confirmPage.dart';

class OtpBody extends StatefulWidget {
  const OtpBody({super.key});

  @override
  State<OtpBody> createState() => _OtpBodyState();
}
class _OtpBodyState extends State<OtpBody> {
   late List<TextEditingController> _controllers;
   late List<FocusNode> _focusNodes;
   Timer? _timer;
  int _remainingSeconds = 30; 
  bool _isResendButtonVisible = false; 
  bool isValid=true;

  @override
  void initState() {
    super.initState();
     _controllers = List.generate(4, (index) => TextEditingController());
    _focusNodes = List.generate(4, (index) => FocusNode());
    _startTimer();
  }
    void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel(); 
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _remainingSeconds = 30; 
      _isResendButtonVisible = false; 
    });

    _timer?.cancel(); 
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isResendButtonVisible = true; 
        });
      }
    });
  }

  void _onTextChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]); 
      } else {
        _focusNodes[index].unfocus(); 
      }
    }
  }

  @override
   
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('OTP Verification',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: kMainColor),
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top:30),
                child: 
                Icon(Icons.verified,
                size:130 ,
                color: kMainColor,),
                ), ),
                const VerticalSpace(6),  
           const  Padding(
              padding:  EdgeInsets.only(left:25,right: 25),
              child:  Text('Check your messages for the verification code to create new password',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16)),
            ),
             const VerticalSpace(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index)=>
              SizedBox(
                height: 50,
                width: 55,
                child: TextField(
                  controller: _controllers[index],
                    focusNode: _focusNodes[index],
                  style: Theme.of(context).textTheme.titleLarge,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  cursorColor: kMainColor,
                   onChanged: (value) => _onTextChanged(value, index),
                  maxLength: 1,
                  decoration: const InputDecoration(
                    hintText: '__',
                    hintStyle:TextStyle(color: Colors.grey),
                    counterText: "", 
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 2),
                    ),focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kMainColor,width: 2),) ),  ),
              )) ),
              const VerticalSpace(8),
              Center(
              child: _isResendButtonVisible
                  ? TextButton(
                      onPressed: _startTimer,
                      child: const  Text(
                        "Resend Code",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    )
                  : Text(
                      "Resend in $_remainingSeconds sec",
                      style: const  TextStyle(fontSize: 16, color: Colors.grey),
                    ),
            ),
          const  VerticalSpace(4),
            Center(
              child: ElevatedButton(
                onPressed: () { 
                  if(isValid){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Confirmpage()));
                  }else{
                    for(var controller in _controllers){
                      controller.clear();
                    }
                    FocusScope.of(context).requestFocus(_focusNodes[0]);
                     ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invalid OTP, please try again")),
                        );}},
                child: Text("Verify OTP"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16,color: kMainColor),
                ),
              ),
            ),
  ]),
)

    );
  }
}