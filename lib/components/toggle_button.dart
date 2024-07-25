import 'package:flutter/material.dart';

class toggleButton extends StatefulWidget {
  toggleButton(
      {super.key,
      required this.icon1,
      required this.icon2,
      required this.stateVariable,
      required this.callBackFunction});
  final Widget icon1;
  final Widget icon2;
  bool stateVariable;
  final Function callBackFunction;
  @override
  State<toggleButton> createState() => _toggleButtonState();
}

class _toggleButtonState extends State<toggleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.stateVariable = !widget.stateVariable;
          widget.callBackFunction();
        });
      },
      child: widget.stateVariable ? widget.icon1 : widget.icon2,
    );
  }
}
