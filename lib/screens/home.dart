import 'package:flutter/material.dart';
import 'package:pm/constants/routes.dart';
import 'package:pm/models/credentials_model.dart';
// import 'package:pm/screens/create__credentials.dart';
import 'package:pm/screens/notes_list_view.dart';
import 'package:pm/screens/widgets/new_note_view.dart';
import 'package:pm/services/notes_services.dart';

import 'create_update_note_view.dart';

class HomeScreen extends StatefulWidget{
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{
  List<Note> credentials = List.empty(growable: true);
  late final NotesService _notesService;
  int count = 0;

  @override
  void initState(){
    _notesService = NotesService();
    super.initState();
  }

  void _incrementCounter(){
    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Credentials(onNewNoteCreated: onNewCredentialCreated,)));
    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const NewNoteView()));
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CreateUpdateNoteView()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password Manager"),
      ),
      // body: ListView.builder(
      //   itemCount: credentials.length,
      //   itemBuilder: (context, index){
      //     return NoteCard(note: credentials[index], index: index, onCredentialDeleted: onCredentialsDeleted,);
      //   },
      // ),
      body: FutureBuilder(
        // future: _notesService.createNote(title: 't', body: 'b'),
        future: _notesService.getAllNotes(),
        builder: (context, snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                stream:_notesService.allNotes,
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if(snapshot.hasData){
                        final allNotes = snapshot.data as List<DatabaseNotes>;
                        print(allNotes);
                        // final allNotes = snapshot.data as Iterable<DatabaseNotes>;
                        return NotesListView(
                                      notes: allNotes,
                                      onDeleteNote: (note) async {
                                        await _notesService.deleteNote(id: note.id);
                                      }, onTap: (note) {
                                        Navigator.of(context).pushNamed(
                                          createOrUpdateNoteRoute,
                                          arguments: note,
                                        );
                                      },
                        );
                      } else{
                        return const CircularProgressIndicator();
                      }
                    default:
                      return const CircularProgressIndicator();
                  }
                },

              );
            case ConnectionState.waiting:
              return const Text('Waiting......');
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
  //
  // void onNewCredentialCreated(Note note){
  //   credentials.add(note);
  //   setState(() {
  //
  //   });
  // }
  // void onCredentialsDeleted(int index){
  //   credentials.removeAt(index);
  //   setState(() {
  //
  //   });
  // }


}
