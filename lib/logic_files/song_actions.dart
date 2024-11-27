
import 'package:audioplayers/audioplayers.dart';

void playSong(AudioPlayer audioPlayer,String songPath)async{
  await audioPlayer.play(DeviceFileSource(songPath));
}
void togglePlayPause(AudioPlayer audioPlayer)async{
  if(audioPlayer.state==PlayerState.playing){
    await audioPlayer.pause();
  }else{
    await audioPlayer.resume();
  }
}
void stopSong(AudioPlayer audioPlayer)async{
  await audioPlayer.stop();
}
