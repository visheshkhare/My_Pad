import 'package:flutter/material.dart';
import 'package:notes/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => NoteProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteListScreen(),
    );
  }
}

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 132, 200, 255),
        centerTitle: true,
        title: Text('My_Pad'),
      ),
      body: Consumer<NoteProvider>(
          builder: (ctx, noteProvider, _) => ListView.builder(
          itemCount: noteProvider.notes.length,   
          itemBuilder: (ctx, index) => ListTile(
            title: Text(noteProvider.notes[index].title),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                noteProvider.deleteNote(noteProvider.notes[index].id);
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => NoteAddScreen(),
            ),
          );
        },
      ),
    );
  }
}

class NoteAddScreen extends StatefulWidget {
  @override
  _NoteAddScreenState createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            ElevatedButton(
              child: Text('Add Note'),
              onPressed: () {
                Provider.of<NoteProvider>(context, listen: false).addNote(
                  _titleController.text,
                  _contentController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}