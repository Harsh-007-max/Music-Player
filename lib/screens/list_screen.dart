import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/logic_files/find_music_from_files.dart';
import 'package:music_player/logic_files/song_actions.dart';
import 'package:music_player/logic_files/sqflite_caching.dart';
import 'package:music_player/utils/logger.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
    State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final AudioPlayer audioPlayer=AudioPlayer();
  late Future<dynamic> _songsList;
  late bool isPlaying ;
  dynamic currentSong;
  @override
    void initState(){
      super.initState();
      logger.i("[1] List Screen");
      _songsList =checkPermission();
      isPlaying = false;
    }
    Future<dynamic> checkPermission()async{
      bool response = await requestStoragePermission();
      if(response){
        return await getSongFromSqLite();
      }else{
        SystemNavigator.pop();
      }
    }
    @override
    void dispose(){
      audioPlayer.dispose();
      super.dispose();
    }
  @override
    Widget build(BuildContext context) {
      return Scaffold(
          body:RefreshIndicator(
            onRefresh:(){
              setState((){
                  cacheSongsIntoSqLite();
                  // _songsList = getSongList();
                  _songsList =  getSongFromSqLite();
              });
              return _songsList;
            },
            child:Column(
              children:[
                ListTile(
                  leading:ClipRRect(
                    borderRadius:BorderRadius.circular(10),
                    child:currentSong!=null && currentSong["albumArt"]!=null ?
                    Image.memory(currentSong["albumArt"],width:50,height:50,fit:BoxFit.cover) :
                    Image.asset("assets/defaults/default_music_thumbnail.jpg",width:50,height:50,fit:BoxFit.cover),
                    ),
                  tileColor:Colors.grey[200],
                  title: currentSong!=null && currentSong['trackName']!=null ?
                  Text(currentSong['trackName']):
                  const Text("No Song Selected"),
                  subtitle: currentSong!=null && currentSong["trackArtistName"]!=null?
                  Text("By ${currentSong["trackArtistName"]}"):
                  const Text("Unknown"),
                ),
              FutureBuilder(
                future:_songsList,
                builder:(context,snapshot){
                if(snapshot.hasData && snapshot.data != null){
                return Expanded(
                  child: ListView.builder(
                    itemCount:snapshot.data!.length,
                    itemBuilder:(context,index){
                    return ListTile(
                        leading:ClipOval(
                          child:
                            snapshot.data[index]["albumArt"]!=null ?
                              Image.memory(snapshot.data![index]["albumArt"],width:50,height:50,fit:BoxFit.cover) :
                              Image.asset("assets/defaults/default_music_thumbnail.jpg",width:50,height:50,fit:BoxFit.cover),
                          ),
                        title:Text(snapshot.data![index]["trackName"]?? "Unknown"),
                        subtitle: Text("By ${snapshot.data![index]["trackArtistName"]}"),
                        onTap:(){
                          if(audioPlayer.state==PlayerState.stopped){
                            playSong(audioPlayer,snapshot.data[index]["filePath"]);
                          }else{
                            if(currentSong!=null && currentSong["filePath"]!=snapshot.data[index]["filePath"]){
                              stopSong(audioPlayer);
                              playSong(audioPlayer,snapshot.data[index]["filePath"]);
                            }else{
                            restartSong(audioPlayer);
                            }
                          }
                          setState(() {
                            isPlaying = true;
                            currentSong=snapshot.data[index];
                           });
                        },
                      );
                    },
                  ),
                );
                }else{
                return const Center(child:CircularProgressIndicator());
              }
                      },
                    ),],
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          setState(() {
            togglePlayPause(audioPlayer);
            isPlaying = !isPlaying;
          });
        },
        child:Icon(currentSong!=null && currentSong["filePath"]!=null && isPlaying? Icons.pause : Icons.play_arrow),
        // child:Icon(CurrentSong!=null && CurrentSong.filePath!=null && audioPlayer.state==PlayerState.playing ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
