import 'package:flutter/material.dart';
import 'package:music_player/components/AppBar.dart';
import 'package:music_player/components/thumbnail.dart';
import 'package:music_player/components/toggle_button.dart';
import 'package:music_player/constants.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    bool isPlaying = true;
    return Scaffold(
      appBar: topBar(musicScreenTitle),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: MusicThumbnail(
                imagePath: defaultThumbnailPath, width: 250, height: 250),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => {print("pressed1")},
                  icon: Icon(Icons.skip_previous,
                       size: iconSize),
                ),
                toggleButton(
                    icon1: Icon(Icons.play_arrow,
                         size: iconSize),
                    icon2: Icon(Icons.pause,  size: iconSize),
                    stateVariable: isPlaying,
                    callBackFunction: () => {}),
                IconButton(
                  onPressed: () => {print("pressed3")},
                  icon: Icon(Icons.skip_next,  size: iconSize),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
