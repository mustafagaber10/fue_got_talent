class SocialUserModel
{
 String? name;
 String? email;
 String? phone;
 String? uid;
 String? image;
 String? bio;
 bool? isEmailVerified;

 SocialUserModel({
   this.name,
   this.email,
   this.phone,
   this.uid,
   this.image,
   this.bio,
   this.isEmailVerified,

 });
 SocialUserModel.fromJson(Map<String, dynamic>json)
 {
   name = json['name'];
   email = json['email'];
   phone = json['phone'];
   uid = json['uid'];
   image = json['image'];
   bio = json['bio'];
   isEmailVerified = json['isEmailVerified'];

 }
 Map<String, dynamic> toMap()
 {
   return {
     'name' : name,
     'email' : email,
     'phone' : phone,
     'uid' : uid,
     'image' : image,
     'bio' : bio,
     'isEmailVerified' : isEmailVerified,

   };
 }

}