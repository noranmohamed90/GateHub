import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gatehub/core/constants.dart';

class CustomeTextfeild extends StatefulWidget {
  const CustomeTextfeild({super.key, this.hinttext, this.type, this.inputFormatter, this.isPassword =false, this.controller,this.onChanged, this.enabled});
  final String ?hinttext;
  final TextInputType? type;
  final List<TextInputFormatter>? inputFormatter;
  final bool  isPassword;
  final TextEditingController?controller;
  final Function(String)? onChanged;
  final bool? enabled;

  @override
  State<CustomeTextfeild> createState() => _CustomeTextfeildState();

}
class _CustomeTextfeildState extends State<CustomeTextfeild> {
   bool _isObscure = true; 
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(left: 25,right: 25, top:10),
            child: TextField(
              enabled: widget.enabled ?? true,
              controller: widget.controller,
              obscureText: widget.isPassword? _isObscure: false,
              keyboardType: widget.type,
              inputFormatters:widget.inputFormatter,
              cursorColor: kMainColor,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
              hintText: widget.hinttext,
              hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.grey) ,
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
              suffixIcon: widget.isPassword 
              ? IconButton(
                  icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility), 
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure; 
                    });
                  },
                )
            
              : null,
            
     ) ));
  }
}