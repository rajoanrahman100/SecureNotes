// To parse this JSON data, do
//
//     final createNoteModel = createNoteModelFromJson(jsonString);

import 'dart:convert';

CreateNoteModel createNoteModelFromJson(String str) => CreateNoteModel.fromJson(json.decode(str));

String createNoteModelToJson(CreateNoteModel data) => json.encode(data.toJson());

class CreateNoteModel {
  String? status;
  String? message;
  Data? data;

  CreateNoteModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateNoteModel.fromJson(Map<String, dynamic> json) => CreateNoteModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;

  Data({
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
