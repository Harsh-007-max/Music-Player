import 'package:flutter/material.dart';

dynamic musicTile(String nameOfMusic,String authorName, String imagePath){
  return ListTile(
    leading: Image.asset(imagePath),
    title: Text(nameOfMusic),
    subtitle: Text(authorName),
  );
}
