//An abstract class cannot be instantiated but they can be sub-classed.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_app/Data/notemodals/notemodals.dart';
import 'package:dio/dio.dart';
import 'package:note_app/Data/url.dart';
import 'get_all_notes/get_all_notes.dart';

//functionality
abstract class ApiCalls {
  Future<Notemodals?> createNote(Notemodals value);
  Future<Notemodals?> updateNote(Notemodals value);
  Future<List<Notemodals>> getAllNotes();
  Future<void> delete(String id);
}

//Working
class NoteDB extends ApiCalls {
//== snigleton
  NoteDB._internal();
  static NoteDB instance = NoteDB._internal();

  factory() {
    return instance;
  }

//== end singleton

  //object creation
  final dio = Dio();
  final url = Url();

  ValueNotifier<List<Notemodals>> noteListNotifier = ValueNotifier([]);

  NoteDB() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }

  @override
  Future<Notemodals?> createNote(Notemodals value) async {
    final _result = await dio.post(
      url.createNote,
      data: value.toJson(),
    );
    final _resultAsjson = jsonDecode(_result.data);
    final note = Notemodals.fromJson(_resultAsjson as Map<String, dynamic>);
    noteListNotifier.value.insert(0, note);
    noteListNotifier.notifyListeners();
    return note;
  }

  @override
  Future<void> delete(String id) async {
    final _result = await dio.delete(url.deleteNote.replaceFirst('{id}', id));
    if (_result.data == null) {
      return;
    }
    final _index = noteListNotifier.value.indexWhere((note) => note.id == id);
    if (_index == -1) {
      return;
    }
    noteListNotifier.value.removeAt(_index);
    noteListNotifier.notifyListeners();
  }

  @override
  Future<List<Notemodals>> getAllNotes() async {
    final _result = await dio.get(url.getAllNotes);
    if (_result.data != null) {
      final _resultAsJson = jsonDecode(_result.data);
      final getNotesResult = GetAllNotes.fromJson(_resultAsJson);
      noteListNotifier.value.clear();
      noteListNotifier.value.addAll(getNotesResult.data.reversed);
      return getNotesResult.data;
    } else {
      noteListNotifier.value.clear();
      return [];
    }
  }

  @override
  Future<Notemodals?> updateNote(Notemodals value) async {
    final _result = await dio.put(url.updateNote, data: value.toJson());
    if (_result.data == null) {
      return null;
    }

    //find index

    final index =
        noteListNotifier.value.indexWhere((note) => note.id == value.id);
    if (index == -1) {
      return null;
    }
    // remove from index
    noteListNotifier.value.removeAt(index);

    // add note in that index
    noteListNotifier.value.insert(index, value);
    noteListNotifier.notifyListeners();
    return value;
  }

  Notemodals? getNoteById(String id) {
    try {
      return noteListNotifier.value.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }

  void deleteNote(String id) {}
}
