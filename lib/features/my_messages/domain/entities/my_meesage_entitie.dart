// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyMeesageEntitie {
  String? sender;
  String? receiver;
  String? text;
  MyMeesageEntitie({this.sender, this.receiver, this.text});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'receiver': receiver,
      'text': text,
    };
  }

  factory MyMeesageEntitie.fromMap(Map<String, dynamic> map) {
    return MyMeesageEntitie(
      sender: map['sender'] != null ? map['sender'] as String : null,
      receiver: map['receiver'] != null ? map['receiver'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyMeesageEntitie.fromJson(String source) =>
      MyMeesageEntitie.fromMap(json.decode(source) as Map<String, dynamic>);
}
