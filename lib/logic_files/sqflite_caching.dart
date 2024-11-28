import 'package:sqflite/sqflite.dart';
class SqfliteCaching{
  static const String dbName="music_player.db";
  static const String tableName="songs";
  static const String columnId="id";
  static const String columnTitle="trackName";
  static const String columnArtistName="trackArtistName";
  static const String albumName="albumName";
  static const String mimeType="mimeType";
  static const String trackDuration="trackDuration";
  static const String bitrate="bitrate";
  static const String filePath="filePath";

  Future<Database> initDb()async{
    String dbPath=await getDatabasesPath();
    Database db = await openDatabase("$dbPath/$dbName",onCreate:(db,version){
      db.execute(
      'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnArtistName TEXT, $albumName TEXT, $mimeType TEXT, $trackDuration INTEGER, $bitrate INTEGER, $filePath TEXT)'
      );
    },version:1);
    return db;
  }
  Future<void> cacheSongsIntoSqLite()async{
    
  }
}
