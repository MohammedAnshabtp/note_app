import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app/Data/data.dart';
import 'package:note_app/Data/notemodals/notemodals.dart';
import 'package:note_app/screens/screen_add_note.dart';

class Screen_all_note extends StatefulWidget {
  Screen_all_note({super.key});

  @override
  State<Screen_all_note> createState() => _Screen_all_noteState();
}

class _Screen_all_noteState extends State<Screen_all_note> {
  final List<Notemodals> noteList = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final _noteList = await NoteDB().getAllNotes();
      noteList.clear();
      setState(() {
        noteList.addAll(_noteList.reversed);
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: EdgeInsets.all(20),
          children: List.generate(
            noteList.length,
            (index) {
              final _note = noteList[index];
              if (_note.id == null) {
                const SizedBox();
              }
              return NoteItem(
                  id: _note.id!,
                  title: _note.title ?? 'NoTitle',
                  content: _note.content ?? 'No content');
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ScreenAddnote(type: ActionType.addNote),
            ),
          );
        },
        label: Text('New'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  const NoteItem({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ScreenAddnote(
              type: ActionType.editNote,
              id: id,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red),
                )
              ],
            ),
            Text(
              content,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
