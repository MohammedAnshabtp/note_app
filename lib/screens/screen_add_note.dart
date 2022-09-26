import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
              break;
            case ActionType.editNote:
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
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
}
