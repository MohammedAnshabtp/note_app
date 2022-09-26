//An abstract class cannot be instantiated but they can be sub-classed.
import 'package:note_app/Data/notemodals/notemodals.dart';
import 'package:dio/dio.dart';
import 'package:note_app/Data/url.dart';

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

  @override
  Future<Notemodals?> createNote(Notemodals value) async {
    final _result = await dio.post<Notemodals>(url.baseUrl + url.createNote);
    return _result.data;
  }

  @override
  Future<void> delete(String id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Notemodals>> getAllNotes() async {
    // TODO: implement getAllNotes
    throw UnimplementedError();
  }

  @override
  Future<Notemodals?> updateNote(Notemodals value) async {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
