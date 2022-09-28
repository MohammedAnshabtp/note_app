import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app/Data/data.dart';
import 'package:note_app/Data/notemodals/notemodals.dart';

enum ActionType {
  addNote,
  editNote,
}

class ScreenAddnote extends StatelessWidget {
  final ActionType type;
  String? id;
  ScreenAddnote({
    Key? key,
    required this.type,
    this.id,
  }) : super(key: key);

  Widget get saveButton => TextButton.icon(
        onPressed: () {
          switch (type) {
            case ActionType.addNote:
              saveNote();
              break;
            case ActionType.editNote:
              saveEditedNote();
              break;
          }
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'Save',
          style: TextStyle(color: Colors.white),
        ),
      );

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (type == ActionType.editNote) {
      if (id == null) {
        Navigator.of(context).pop();
      }

      final note = NoteDB.instance.getNoteById(id!);
      if (note == null) {
        Navigator.of(context).pop();
      }
      _titleController.text = note!.title ?? 'No title';
      _contentController.text = note.content ?? 'No content';
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(type.name.toUpperCase()),
        actions: [
          saveButton,
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                maxLines: 4,
                maxLength: 100,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Content',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;

    //constructor
    final _newNote = Notemodals.create(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
    );

    //server sending
    final newNote = await NoteDB().createNote(_newNote);
    if (newNote != null) {
      print('Note Saved');
      Navigator.of(_scaffoldKey.currentContext!).pop();
    } else {
      print('Error while saving note');
    }
  }

  Future<void> saveEditedNote() async {
    final _title = _titleController.text;
    final _content = _contentController.text;

    final editedNote = Notemodals.create(
      id: id,
      title: _title,
      content: _content,
    );

    final _note = await NoteDB.instance.updateNote(editedNote);
    if (_note == null) {
      print('Unable to update note');
    } else {
      Navigator.of(_scaffoldKey.currentContext!).pop();
    }
  }
}
