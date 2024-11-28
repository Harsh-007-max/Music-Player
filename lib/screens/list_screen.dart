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
  late Future<dynamic> _songsList;
  late bool isPlaying ;
  dynamic CurrentSong;
  @override
    void initState() {
      super.initState();
      logger.i("[1] List Screen");
      _songsList=getSongList();
      isPlaying = false;
    }
    @override
    void dispose(){
      audioPlayer.dispose();
      super.dispose();
    }
  @override
    Widget build(BuildContext context) {
      return Scaffold(
          // appBar: appBar(title:"Music Player"),
          body:RefreshIndicator(
            onRefresh:(){
              setState(() {
                _songsList=getSongList();
              });
              return _songsList;
            },
            child: FutureBuilder(
              future:_songsList,
              builder:(context,snapshot){
              if(snapshot.hasData && snapshot.data != null){
              return Column(
                children: [
                    ListTile(
                    leading:ClipRRect(
                      borderRadius:BorderRadius.circular(10),
                      child:CurrentSong!=null && CurrentSong.albumArt!=null ?
                        Image.memory(CurrentSong.albumArt,width:50,height:50,fit:BoxFit.cover) :
                        Image.asset("assets/defaults/default_music_thumbnail.jpg",width:50,height:50,fit:BoxFit.cover),
                    ),
                    tileColor:Colors.grey[200],
                    title: CurrentSong!=null && CurrentSong.trackName!=null ?
                      Text(CurrentSong.trackName):
                      const Text("No Song Selected"),
                    subtitle: CurrentSong!=null && CurrentSong.trackArtistNames[0]!=null?
                      Text("By ${CurrentSong.trackArtistNames[0]}"):
                      const Text("Unknown"),
            
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount:snapshot.data!.length,
                      itemBuilder:(context,index){
                      return ListTile(
                          leading:ClipOval(
                            child:
                              snapshot.data[index].albumArt!=null ?
                                Image.memory(snapshot.data![index].albumArt,width:50,height:50,fit:BoxFit.cover) :
                                Image.asset("assets/defaults/default_music_thumbnail.jpg",width:50,height:50,fit:BoxFit.cover),
                            ),
                          title:Text(snapshot.data![index].trackName ?? "Unknown"),
                          subtitle: Text("By ${snapshot.data![index].trackArtistNames[0]}"),
                          onTap:(){
                            if(audioPlayer.state==PlayerState.stopped){
                              playSong(audioPlayer,snapshot.data[index].filePath);
                            }else{
                              restartSong(audioPlayer);
                            }
                            setState(() {
                              isPlaying = true;
                              CurrentSong=snapshot.data[index];
                             });
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
              }else{
              return const Center(child:CircularProgressIndicator());
            }
                    },
                  ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          setState(() {
            togglePlayPause(audioPlayer);
            isPlaying = !isPlaying;
          });
        },
        child:Icon(CurrentSong!=null && CurrentSong.filePath!=null && isPlaying? Icons.pause : Icons.play_arrow),
        // child:Icon(CurrentSong!=null && CurrentSong.filePath!=null && audioPlayer.state==PlayerState.playing ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
