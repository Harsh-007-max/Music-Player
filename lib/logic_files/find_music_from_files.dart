import 'dart:io';

import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:music_player/utils/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

PermissionStatus? status;
Future<void> requestStoragePermission()async{
  status = await Permission.audio.status;
  if(!status!.isGranted){
    status= await Permission.audio.request();  
    if(status!.isGranted){
      logger.i("[1] Storage Permission Granted");
    }else{
      logger.e("[1] Storage Permission Denied");
    }
  }else{
    logger.i("[1] Storage Permission Already Granted");
  }
}

Future<List<File>> getAllSongFiles() async{
  List<File> mp3Files=[];
  Directory directory=Directory("/storage/emulated/0/Music");
  try{
    await for(var entity in directory.list(recursive:true,followLinks:false)){
      if(entity is File && path.extension(entity.path).toLowerCase()==".mp3"){
        mp3Files.add(entity);
      }
    }
  }catch(e){
    logger.e("[2] error scanning directory: $e");
  }
  logger.i("[2] Found ${mp3Files.length} mp3 files");
  return mp3Files;
}

Future<void> getSongMetadata(File songFile)async{
  try{
    final metadata=await MetadataRetriever.fromFile(songFile);
  }catch(e){
    logger.e("[3] error reading metadata: $e");
  }
}

Future<dynamic> getSongList()async{
  List<File> mp3Files=await getAllSongFiles();
  List<dynamic> songList=[];
  for(var songFile in mp3Files){
    try{
      final metadata=await MetadataRetriever.fromFile(songFile);
      songList.add(metadata);
    }catch(e){
      logger.e("[4] error reading metadata: $e");
    }
  }
  logger.i(songList);
  return songList;
}

void storage_music_functions(){
  requestStoragePermission().then((value)=>{
    getAllSongFiles()
  });
}
