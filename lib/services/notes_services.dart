import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pm/services/crud_exceptions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
//19hr 5min

class NotesService {
  Database? _db;

  List<DatabaseNotes> _notes = [];

  static final NotesService _shared = NotesService._sharedInstance();
  NotesService._sharedInstance(){
    _notesStreamController = StreamController<List<DatabaseNotes>>.broadcast(
        onListen:() {
          _notesStreamController.sink.add(_notes);
        },
    );
  }
  factory NotesService() => _shared;

  late final StreamController<List<DatabaseNotes>> _notesStreamController;

  Stream<List<DatabaseNotes>> get allNotes => _notesStreamController.stream;

  Future<void> _cacheNotes() async {
    final allNotes = await getAllNotes();
    _notes = allNotes.toList();
    _notesStreamController.add(_notes);
  }

  Future<DatabaseNotes> updateNote({ //19hr 26min
    required DatabaseNotes note,
    required String text}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    //make sure note exists
    await getNote(id: note.id);

    final updatesCount = await db.update(noteTable, {
      titleColumn: text,
      bodyColumn: text,
    },
      where: 'id = ?',
      whereArgs: [note.id],
    );
    if(updatesCount == 0){
      throw CouldNoteUpdateNote();
    } else {
      final updatedNote =  await getNote(id: note.id);
      _notes.removeWhere((note) => note.id == updatedNote.id);
      _notes.add(updatedNote);
      _notesStreamController.add(_notes);
      return updatedNote;
    }
  }

  Future<Iterable<DatabaseNotes>> getAllNotes() async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final notes = await db.query(noteTable);
    
    return notes.map((noteRow) => DatabaseNotes.fromRow(noteRow));
  }

  Future<DatabaseNotes> getNote({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final notes = await db.query(
      noteTable,
      limit:1,
      where: 'id = ?',
      whereArgs: [id],
    );
    if(notes.isEmpty){
      throw CouldNotFindNotes();
    } else {
      final note =  DatabaseNotes.fromRow(notes.first);
      _notes.removeWhere((note) => note.id == id);
      _notes.add(note);
      _notesStreamController.add(_notes);
      return note;
    }

  }

  // Future<DatabaseNotes> createNote({required String title, required String body}) async {
  //   await _ensureDbIsOpen();
  //   final db = _getDatabaseOrThrow();
  //   final results = await db.query(noteTable,
  //     limit:1,
  //     where: 'title = ?',
  //     whereArgs: [title.toLowerCase()],
  //   );
  //   if(results.isNotEmpty){
  //     throw NoteTitleAlreadyExists();
  //   }
  //
  //   final noteId = await db.insert(noteTable, {
  //     // titleColumn: title.toLowerCase(),
  //     // bodyColumn: body.toLowerCase(),
  //     titleColumn: "",
  //     bodyColumn: "",
  //   });
  //
  //   final note = DatabaseNotes(id: noteId, title: "", body: "");
  //   // return DatabaseNotes(
  //   //     id: noteId,
  //   //     title: title,
  //   //     body: body,
  //   // );
  //   _notes.add(note);
  //   _notesStreamController.add(_notes);
  //
  //   return note;
  // }
  Future<DatabaseNotes> createNote() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    final noteId = await db.insert(noteTable, {
      titleColumn: "",
      bodyColumn: "",
    });

    final note = DatabaseNotes(id: noteId, title: "", body: "");
    _notes.add(note);
    _notesStreamController.add(_notes);

    return note;
  }

  Future<int> deleteAllNotes() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final numberOfDeletions = await db.delete(noteTable);
    _notes = [];
    _notesStreamController.add(_notes);
    return numberOfDeletions;
  }

  Future<void> deleteNote({required int id}) async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      noteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (deletedCount == 0){
      throw CouldNotDeleteNote();
    } else {
      // final countBefore = _notes.length;
      _notes.removeWhere((note) => note.id == id);
      _notesStreamController.add(_notes);
    }
  }

  Database _getDatabaseOrThrow(){
    final db = _db;
    if(db == null){
      throw DatabaseIsNotOpen();
    }else{
      return db;
    }
  }

  Future<void> close() async {
    final db = _db;
    if(db == null){
      throw DatabaseIsNotOpen();
    }else{
      await db.close();
      _db = null;
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try{
      await open();
    } on DatabaseAlreadyOpenException{}
  }

  Future<void> open() async {
    if(_db != null){
      throw DatabaseAlreadyOpenException();
    }
    try{
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      await db.execute(createNoteTable);
      await _cacheNotes();

    } on MissingPlatformDirectoryException{
        throw UnableToGetDocumentsDirectory();
    }
  }
}

@immutable
class DatabaseNotes{
  final int id;
  final String title;
  final String body;

  // const DatabaseNotes(this.id, {required this.title, required this.body});
  const DatabaseNotes({required this.id, required this.title, required this.body});

  DatabaseNotes.fromRow(Map<String, Object?> map):
      id = map[idColumn] as int,
      title = map[titleColumn] as String,
      body = map[bodyColumn] as String;

  @override
  String toString() => 'Person, id = $id, title = $title, body = $body';

  @override bool operator == (covariant DatabaseNotes other) => id == other.id;

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode;
  }

  const dbName = 'notes.db';
  const noteTable = 'note';
  const idColumn = "id";
  const titleColumn ="title";
  const bodyColumn ="body";
  //create note table
  const createNoteTable = ''' CREATE TABLE IF NOT EXISTS "note" (
          "id" INTEGER NOT NULL,
          "title" TEXT NOT NULL,
          "body" TEXT,
          PRIMARY KEY("id" AUTOINCREMENT)
        );
        ''';

