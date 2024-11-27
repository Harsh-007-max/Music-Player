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
          appBar: appBar(title:"Music Player"),
          body: FutureBuilder(
            future:getSongList(),
            builder:(context,snapshot){
            if(snapshot.hasData && snapshot.data != null){
            return ListView.builder(
                itemCount:snapshot.data!.length,
                itemBuilder:(context,index){
                return ListTile(
                    leading:ClipOval(child:snapshot.data[index].albumArt!=null?Image.memory(snapshot.data![index].albumArt,width:50,height:50,fit:BoxFit.cover):Image.asset("assets/defaults/default_music_thumbnail.jpg",width:50,height:50,fit:BoxFit.cover)),
                    title:Text(snapshot.data![index].trackName ?? "Unknown"),
                    subtitle: Text(snapshot.data![index].trackArtistNames[0] ?? "Unknown"),
                    onTap:(){
                      if(audioPlayer.state==PlayerState.stopped){
                        playSong(audioPlayer,snapshot.data[index].filePath);
                      }else{
                        togglePlayPause(audioPlayer);
                      }
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
