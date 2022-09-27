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
    final _result =
        await dio.post(url.baseUrl + url.createNote, data: value.toJson());
    final _resultAsjson = jsonDecode(_result.data);
    return Notemodals.fromJson(_result.data as Map<String, dynamic>);
  }

  @override
  Future<void> delete(String id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Notemodals>> getAllNotes() async {
    final _result = await dio.get(url.getAllNotes);
    if (_result.data != null) {
      final _resultAsJson = jsonDecode(_result.data);
      final getNotesResult = GetAllNotes.fromJson(_resultAsJson);
      noteListNotifier.value.clear();
      noteListNotifier.value.addAll(getNotesResult.data);
      return getNotesResult.data;
    } else {
      noteListNotifier.value.clear();
      return [];
    }
  }

  @override
  Future<Notemodals?> updateNote(Notemodals value) async {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
