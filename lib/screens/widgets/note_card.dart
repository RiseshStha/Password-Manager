import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pm/models/credentials_model.dart';
import 'package:pm/screens/note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note, required this.index, required this.onCredentialDeleted}) : super(key: key);

  final Note note;
  final int index;

  final Function(int) onCredentialDeleted;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NoteView(note: note, index: index, onCredentialDeleted: onCredentialDeleted)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                note.body,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
