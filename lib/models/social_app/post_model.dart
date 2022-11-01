

import 'package:cloud_firestore/cloud_firestore.dart';

class Video
{
  String? name;
  String? uid;
  // String? id;
  String? image;
  dynamic dateTime;
  String? description;
  String? postVideo;
  String? thumbnail;
  String? category;
  Map? ratings;
  int? commentCount;
  int? ratingCount ;
  Map? form;

  Video({
    this.name,
    this.uid,
    // this.id,
    this.image,
    this.dateTime,
    this.description,
    this.postVideo,
    this.thumbnail,
    this.category,
    this.ratings,
    this.commentCount,
    this.ratingCount,
    this.form,

  });
  Video.fromDoc(DocumentSnapshot doc)
  {
    name = doc['name'];
    uid = doc['uid'];
    // id = json['id'];
    image = doc['image'];
    dateTime = doc['dateTime'];
    description = doc['description'];
    postVideo = doc['postVideo'];
    thumbnail = doc['thumbnail'];
    ratings = doc['ratings'];
    commentCount = doc['commentCount'];
    category = doc['category'];
    ratingCount = doc['ratingCount'];
    form = doc['form'];

  }
  Video.fromJson(Map<String, dynamic>json)
  {
    name = json['name'];
    uid = json['uid'];
    // id = json['id'];
    image = json['image'];
    dateTime = json['dateTime'];
    description = json['description'];
    postVideo = json['postVideo'];
    thumbnail = json['thumbnail'];
    ratings = json['ratings'];
    commentCount = json['commentCount'];
    category = json['category'];
    ratingCount = json['ratingCount'];
    form = json['form'];

  }

  Map<String, dynamic> toMap()
  {
    return {
          'name' : name,
          'uid' : uid,
          'image' : image,
          'dateTime' : dateTime,
          'description' : description,
          'postVideo' : postVideo,
          'thumbnail' : thumbnail,
          'ratings' : ratings,
          'commentCount' : commentCount,
          'category' : category,
          'ratingCount' : ratingCount,
          'form' : form,

    };
  }
  // int getRatingCount(ratings){
  //   if( ratings == null){
  //       return 0 ;
  //   }
  //   int count = 0;
  //   ratings.values.forEach((val){
  //     if( val <= 5 || val >=0){
  //       count += 1;
  //     }
  //   });
  //   return count;
  // }

}