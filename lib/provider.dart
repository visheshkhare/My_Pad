import 'package:flutter/foundation.dart';
import 'note_provider.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes {
    return [..._notes];
  }

  void addNote(String title, String content) {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      content: content,
    );
    _notes.add(newNote);
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}