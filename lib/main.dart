import 'package:flutter/material.dart';
import 'package:music_player/screens/player.dart';
import 'package:music_player/themes/theme.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: Text("Hello World!"),
//         ),
//       ),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      home:PlayerScreen(),
    );
  }
}
