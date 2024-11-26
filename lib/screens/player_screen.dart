import 'package:flutter/material.dart';
import 'package:music_player/components/app_bar.dart';
import 'package:music_player/logic_files/find_music_from_files.dart';
import 'package:music_player/utils/logger.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  void initState() {
    super.initState();
    logger.i("[1] Player Screen");
    // storage_music_functions();
  }
  @override
  Widget build(BuildContext context) {
    logger.i("[0] Player Screen");
    return Scaffold(
      appBar: appBar(title:"Current Song"),
      body: const Center(
        child: Text("Playing Song"), 
        ),
    );
  }
}
