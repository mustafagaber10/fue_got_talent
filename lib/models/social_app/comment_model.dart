import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel
{
   String? name;
   String? uid;
   dynamic dateTime;
   String? text;
   String? image;

  CommentModel({
     this.name,
     this.uid,
     this.dateTime,
     this.text,
     this.image,
  });
   CommentModel.fromDoc(DocumentSnapshot doc)
   {
     name = doc['name'];
     uid = doc['uid'];
     dateTime = doc['dateTime'];
     text = doc['text'];
     image = doc['image'];

   }
  CommentModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uid = json['uid'];
    dateTime = json['dateTime'];
    text = json['text'];
    image = json['image'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uid,
      'dateTime':dateTime,
      'text':text,
      'image' : image,
    };
  }
}