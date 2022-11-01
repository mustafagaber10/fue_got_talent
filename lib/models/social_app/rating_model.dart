
class RatingModel
{
  final String username;
  final double rating ;

  RatingModel({
    required this.username,
    required this.rating,
  });
  // CommentModel.fromJson(Map<String, dynamic> json)
  // {
  //   name = json['name'];
  //   uid = json['uid'];
  //   dateTime = json['dateTime'];
  //   text = json['text'];
  //   image = json['image'];
  //
  // }
  factory RatingModel.getModelFromJson({required Map<String, dynamic> json}){
    return RatingModel(
        username: json['username'],
        rating: json['rating']
    );
  }

  Map<String, dynamic> toMap()
  {
    return {
      'username':username,
      'rating' : rating,
    };
  }
}