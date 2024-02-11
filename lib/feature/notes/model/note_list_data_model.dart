// To parse this JSON data, do
//
//     final noteListDataModel = noteListDataModelFromJson(jsonString);

import 'dart:convert';

NoteListDataModel noteListDataModelFromJson(String str) => NoteListDataModel.fromJson(json.decode(str));

String noteListDataModelToJson(NoteListDataModel data) => json.encode(data.toJson());

class NoteListDataModel {
  String? status;
  String? message;
  List<Note>? data;

  NoteListDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory NoteListDataModel.fromJson(Map<String, dynamic> json) => NoteListDataModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Note>.from(json["data"]!.map((x) => Note.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Note {
  String? id;
  String? status;
  String? description;
  String? title;

  Note({
    this.id,
    this.status,
    this.description,
    this.title,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    status: json["status"],
    description: json["description"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "description": description,
    "title": title,
  };
}
