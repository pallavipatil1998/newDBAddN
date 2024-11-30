import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{

  AppDatabase._();

  static final AppDatabase db=AppDatabase._();

  Database? _database;

 Future<Database>getDB() async{
    if(_database!=null){
      return _database! ;
    }else{
      return await initDB();
    }
  }

  Future<Database>initDB()async{
   Directory documentDirectory=await getApplicationDocumentsDirectory();
   var dbPath= join(documentDirectory.path,"noteDB.db");
   return openDatabase(dbPath,version: 1,
       onCreate: (db,version){
     db.execute("create table note(note_id integer primary key autoincrement,title text,desc text )");
   }
   );
  }

  Future<bool> addNote(String title,String desc)async{
   var d1=await getDB();
   int rowsEffected=await d1.insert('note', {'title':title,'desc':desc});
   if(rowsEffected>0){
     return true;
   }else{
     return false;
   }
  }

  Future<List<Map<String,dynamic>>>fetchAllNotes()async{
   var d2=await getDB();
   List<Map<String,dynamic>>notes=await d2.query("note");
   return notes;
  }

}