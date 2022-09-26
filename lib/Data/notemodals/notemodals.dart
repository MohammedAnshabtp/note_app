import 'package:json_annotation/json_annotation.dart';

part 'notemodals.g.dart';

@JsonSerializable()
class Notemodals {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'content')
  String? content;

  Notemodals({this.id, this.title, this.content});

  //Named Constructor
  Notemodals.create(
      {required this.id, required this.title, required this.content});

  factory Notemodals.fromJson(Map<String, dynamic> json) {
    return _$NotemodalsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotemodalsToJson(this);
}
