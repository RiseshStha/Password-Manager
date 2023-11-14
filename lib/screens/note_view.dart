import 'package:flutter/material.dart';
import 'package:pm/models/credentials_model.dart';

class NoteView extends StatelessWidget {
  const NoteView({Key? key, required this.note, required this.index, required this.onCredentialDeleted}) : super(key: key);

  final Note note;
  final int index;

  final Function(int) onCredentialDeleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credentials"),
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context,
                builder: (context){
              return AlertDialog(
                title: const Text("Delete This ?"),
                content: Text("Note ${note.title} will be deleted!"),
                
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                    onCredentialDeleted(index);
                    Navigator.of(context).pop();
                  },
                      child: const Text("DELETE")
                  ),
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  },
                      child: const Text("CANCEL")
                  ),
                ],
              );
                });
          }, icon: const Icon(Icons.delete)),
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.edit)),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start
          ,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 26
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              note.body,
              style: const TextStyle(
                fontSize: 18
              ),
            ),
          ],
        ),
      ),
    );
  }
}
