import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/components/app_bar.dart';
import 'package:music_player/logic_files/find_music_from_files.dart';
import 'package:music_player/logic_files/song_actions.dart';
import 'package:music_player/utils/logger.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
    State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final AudioPlayer audioPlayer=AudioPlayer();
  @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: appBar(title:"List Page"),
          body: FutureBuilder(
            future:getSongList(),
            builder:(context,snapshot){
            if(snapshot.hasData && snapshot.data != null){
            return ListView.builder(
                itemCount:snapshot.data!.length,
                itemBuilder:(context,index){
                return ListTile(
                    leading:snapshot.data[index].albumArt!=null?Image.memory(snapshot.data![index].albumArt):Image.asset("assets/defaults/default_music_thumbnail.jpg"),
                    title:Text(snapshot.data![index].trackName ?? "Unknown"),
                    subtitle: Text(snapshot.data![index].trackArtistNames[0] ?? "Unknown"),
                    onTap:(){
                      playSong(audioPlayer,snapshot.data[index].filePath);
                    },
                  );
                },
              );
            }else{
            return const Center(child:CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
