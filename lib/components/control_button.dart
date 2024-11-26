import 'package:flutter/material.dart';

dynamic controlButton({required IconData icon, required Function onPressed, required double paddingValue,double elevationValue=0.0, Color iconColor=Colors.black,Color  foregroundColor=Colors.black,Color backgroundColor=Colors.black}) {
  return ElevatedButton(
      style:ElevatedButton.styleFrom(
        padding: EdgeInsets.all(paddingValue),
        elevation: elevationValue,
        iconColor: iconColor,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        
      ),
      onPressed: ()=>onPressed(),
      child: Icon(icon),
      );

}
