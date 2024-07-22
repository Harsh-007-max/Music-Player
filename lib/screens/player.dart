import 'package:flutter/material.dart';
import 'package:music_player/components/AppBar.dart';
import 'package:music_player/components/thumbnail.dart';
import 'package:music_player/constants.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(Music_Screen_Title),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MusicThumbnail(
                imagePath: Default_Thumbnail_Path, width: 250, height: 250),
          ),
          const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.skip_previous, color: Colors.black, size: 40),
                Icon(Icons.play_arrow, color: Colors.black, size: 40),
                Icon(Icons.skip_next, color: Colors.black, size: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
