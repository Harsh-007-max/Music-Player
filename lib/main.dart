import 'package:flutter/material.dart';
import 'package:music_player/screens/list_screen.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    Widget build(BuildContext context) {
      return const SafeArea(
          child: MaterialApp(
            home: ListScreen()
            ),
          );
    }
}
