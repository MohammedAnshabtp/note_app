import 'package:json_annotation/json_annotation.dart';

import '../notemodals/notemodals.dart';

part 'get_all_notes.g.dart';

@JsonSerializable()
class GetAllNotes {
  @JsonKey(name: 'data')
  List<Notemodals> data;

  GetAllNotes({this.data = const []});

  factory GetAllNotes.fromJson(Map<String, dynamic> json) {
    return _$GetAllNotesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllNotesToJson(this);
}
