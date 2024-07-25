import 'package:flutter/material.dart';
import 'package:music_player/constants.dart';

class MusicThumbnail extends StatefulWidget {
  const MusicThumbnail({super.key, this.width, this.height, this.imagePath});
  final String? imagePath;
  final double? width, height;
  @override
  State<MusicThumbnail> createState() => _MusicThumbnailState();
}

class _MusicThumbnailState extends State<MusicThumbnail> {
  late String imagePath;
  late double width, height;
  @override
  void initState() {
    super.initState();
    imagePath = widget.imagePath ?? defaultThumbnailPath;
    width = widget.width ?? defaultWidth;
    height = widget.height ?? defaultHeight;
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
      ),
    );
  }
}
