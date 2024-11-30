import 'package:music_player/logic_files/find_music_from_files.dart';
import 'package:music_player/utils/logger.dart';
import 'package:sqflite/sqflite.dart';
const String dbName="music_player.db";
const String tableName="songs";
const String columnId="id";
const String columnTitle="trackName";
const String columnArtistName="trackArtistName";
const String albumName="albumName";
const String mimeType="mimeType";
const String trackDuration="trackDuration";
const String bitrate="bitrate";
const String filePath="filePath";
const String albumArt="albumArt";
Future<Database> initDb()async{
  String dbPath=await getDatabasesPath();
  Database db = await openDatabase("$dbPath/$dbName",onCreate:(db,version){
      db.execute(
          'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnTitle TEXT, $columnArtistName TEXT, $albumName TEXT, $mimeType TEXT, $trackDuration INTEGER, $bitrate INTEGER, $filePath TEXT, $albumArt BLOB)'
          );
      },version:1);
  return db;
}
Future<void> cacheSongsIntoSqLite()async{
  Database db = await initDb();
  dynamic records = await getSongList();
  await clearSqLiteSongCache();
  Batch songBatch = db.batch();
  for(dynamic record in records){
    songBatch.insert(tableName, {
      columnTitle: record.trackName,
      columnArtistName: record.trackArtistNames[0],
      albumName: record.albumName,
      mimeType: record.mimeType,
      trackDuration: record.trackDuration,
      bitrate: record.bitrate,
      filePath: record.filePath,
      albumArt: record.albumArt,
    });
  }
  await songBatch.commit();
}
Future<dynamic> getSongFromSqLite()async{
  dynamic db = await initDb();
  dynamic data = await db.query(tableName);
  if(data.length==0){
    await cacheSongsIntoSqLite();
    data = await db.query(tableName);
    logger.e("Cached songs into sqllite table ${data[0]}");
  }else{
    logger.e("Fetched songs from sqllite table ${data[0]["trackName"]}");
  } 
  return data;
}
Future<dynamic> getSongFromSqLiteById(columnId)async{
  dynamic db = await initDb();
  dynamic data = db.query(tableName, where: '$columnId = ?', whereArgs: [columnId]);
  return data;
}
Future<dynamic> deleteSongFromSqLite(columnId)async{
  dynamic db = await initDb();
  dynamic data = db.delete(tableName, where: '$columnId = ?', whereArgs: [columnId]);
  return data;
}
Future<dynamic> insertSongsIntoSqLite(songData) async{
  dynamic db = await initDb();
  dynamic data = db.insert(tableName, {
    columnTitle: songData.columnTitle,
    columnArtistName: songData.columnArtistName,
    albumName: songData.albumName,
    mimeType: songData.mimeType,
    trackDuration: songData.trackDuration,
    bitrate: songData.bitrate,
    filePath: songData.filePath
  });
  return data;
}
Future<dynamic> clearSqLiteSongCache()async{
  Database db = await initDb();
  dynamic data = db.delete(tableName);
  return data;
}
