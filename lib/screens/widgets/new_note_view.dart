// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:pm/services/notes_services.dart';
// //21hr 30 min
// class NewNoteView extends StatefulWidget {
//   const NewNoteView({Key? key}) : super(key: key);
//
//   @override
//   State<NewNoteView> createState() => _NewNoteViewState();
// }
//
// class _NewNoteViewState extends State<NewNoteView> {
//   DatabaseNotes? _note;
//   late final NotesService _notesService;
//   late final TextEditingController _textController;
//
//   @override
//   void initState(){
//     _notesService = NotesService();
//     _textController = TextEditingController();
//     super.initState();
//   }
//
//   void _textControllerListener() async {// check code properly here
//     final note = _note;
//     if(note == null){
//       return;
//     }
//     final text = _textController.text;
//     await _notesService.updateNote(
//         note: note,
//         text: text
//     );
//   }
//
//   void _setupTextControllerListener(){
//     _textController.removeListener(_textControllerListener);
//     _textController.addListener(_textControllerListener);
//   }
//
//
//   Future<DatabaseNotes> createNewNote() async {
//     final existingNote = _note;
//     print(existingNote);
//     print("existing note");
//     if(existingNote != null){
//       return existingNote;
//     }
//     return await _notesService.createNote();
//   }
//
//   void _deleteNoteIfTextIsEmpty(){
//     final note = _note;
//     if(_textController.text.isEmpty && note != null){
//       _notesService.deleteNote(id: note.id);
//     }
//   }
//
//   void _saveNoteIfTextNotEmpty() async {
//     final note = _note;
//     final text = _textController.text;
//     if(note != null && text.isNotEmpty){
//       await _notesService.updateNote(
//           note: note,
//           text: text
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _deleteNoteIfTextIsEmpty();
//     _saveNoteIfTextNotEmpty();
//     _textController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const  Text('New Note'),
//       ),
//       body: FutureBuilder(
//         future: createNewNote(),
//         builder: (context, snapshot){
//           switch (snapshot.connectionState){
//             case ConnectionState.done:
//               _note = snapshot.data as DatabaseNotes;
//               _setupTextControllerListener();
//               return TextField(
//                controller: _textController,
//                keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 decoration: const InputDecoration(
//                   hintText: 'Start typing your notes...'
//                 ),
//               );
//             default:
//               return const CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
