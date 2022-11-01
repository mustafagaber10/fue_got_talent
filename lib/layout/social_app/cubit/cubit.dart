import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fue_got_talent/layout/social_app/cubit/states.dart';
import 'package:fue_got_talent/models/social_app/comment_model.dart';
import 'package:fue_got_talent/models/social_app/post_model.dart';
import 'package:fue_got_talent/models/social_app/rating_model.dart';
import 'package:fue_got_talent/models/social_app/social_user_model.dart';
import 'package:fue_got_talent/modules/social_app/feeds/feeds_screen.dart';
import 'package:fue_got_talent/modules/social_app/new_post/new_post_screen.dart';
import 'package:fue_got_talent/modules/social_app/profile/profile_screen.dart';
import 'package:fue_got_talent/modules/social_app/social_login/social_login_screen.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/components/constants.dart';
import 'package:fue_got_talent/shared/network/local/cache_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  void getUserData()  {
    uid = CacheHelper.getData(key:'uid');
    emit(SocialGetUserLoadingState());
     FirebaseFirestore.instance.collection('users')
     .doc(uid)
     .get()
     .then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);

      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    NewPostScreen(),
    ProfileScreen(),
  ];
  List<String> titles = [
    "Home",
    'Post',
    'Profile',
  ];
  void changeBottomNav(int index) {
    if (index == 1)
    {
      emit(SocialNewPostState());
    }
    else
    {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  ImagePicker? picker = ImagePicker();
  // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  Future<void> getProfileImage() async {
    final pickedFile = await picker?.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      // print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      // print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  String? profilePicURL;

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    //"/data/user/0/com.example.fue_got_talent/cache/image_picker1831505106699694295.jpg"
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // print(value);
        // profileImageUrl = value;
        updateUser(name: name, phone: phone, bio: bio, profImg: value);
        // emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        // print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      // print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? profImg
  }) {
    emit(SocialUpdateUserLoadingState());

    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      uid: userModel!.uid,
      image: profImg??userModel!.image,
      isEmailVerified: false,

    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uid)
        .update(model.toMap()).then((value)
    {
      getUserData();
      emit(SocialUpdateUserSuccessState());

    }).catchError((error)
    {
      // print(error.toString());
      emit(SocialUpdateUserErrorState());
    });
  }

  File? postVideo;
  String? postVideoPath;
  VideoPlayerController? controller;

  void getPostVideo (ImageSource src,BuildContext context) async
  {
    final pickedVideo = await picker?.pickVideo(source: src);
    if (pickedVideo != null) {
      // navigateTo(context, ConfirmScreen(
      //   videoFile:  File(pickedVideo.path),
      //   videoPath: pickedVideo.path,
      //   ),
      // );
      // navigateTo(context, inquiry()
      // );
      postVideo = File(pickedVideo.path);
      postVideoPath = pickedVideo.path;
      controller = VideoPlayerController.file(postVideo!);
      // controller?.initialize();
      // controller?.play();
      // controller?.setVolume(1);
      // controller?.setLooping(false);
      Navigator.pop(context);
      // print(pickedVideo.path);
      emit(SocialPostVideoPickedSuccessState());
    } else {
      // print('No video Selected');
      emit(SocialPostVideoPickedErrorState());
    }
  }
  void removePostVideo()
  {
    postVideo =null;
    postVideoPath=null;
    emit(SocialRemovePostVideoState());
  }
  _getThumbnail(String postVideoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(
        postVideoPath,
    );
    return thumbnail;
  }
  _compressVideo(String postVideoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
        postVideoPath,
        quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }
  // Future<String> _uploadVideoToStorage(String id , String postVideoPath)async{
  //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref()
  //   .child('videos').child(id);
  //
  //   firebase_storage.UploadTask uploadTask= ref.putFile(await _compressVideo(postVideoPath));
  //   firebase_storage.TaskSnapshot snapshot = await uploadTask;
  //   String downloadURL = await snapshot.ref.getDownloadURL();
  //   return downloadURL;
  // }
  Future<String> _uploadImageToStorage(String postVideoPath)async{
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref()
        .child('thumbnails/${Uri.file(postVideo!.path).pathSegments.last}');

    firebase_storage.UploadTask uploadTask= ref.putFile(await _getThumbnail(postVideoPath));
    firebase_storage.TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
  Map<String,String>? form;
  void uploadPost({String? description,required String category,required Map<String,String>form})async
  {

    // try{
    //   emit(SocialCreatePostLoadingState());
    //   String uid = FirebaseAuth.instance.currentUser!.uid;
    //   var allDocs = await FirebaseFirestore.instance.collection('video').get();
    //   int len = allDocs.docs.length;
    //   String videoURL = await _uploadVideoToStorage("Video $len",postVideoPath!);
    //   String videoThumbnail = await _uploadImageToStorage("Video $len",postVideoPath!);
    //   Video video = Video(
    //     name:userModel!.name,
    //     uid: uid,
    //     id:"Video $len",
    //     ratings: [],
    //     commentCount: 0,
    //     dateTime: dateTime,
    //     description: description,
    //     image: userModel!.image,
    //     postVideo: videoURL,
    //     thumbnail: videoThumbnail,
    //     category: category,
    //   );
    //   await FirebaseFirestore.instance.collection('videos').doc('Video $len').set(video.toJson());
    //   emit(SocialCreatePostSuccessState());
    //
    // }catch(e){
    //   emit(SocialCreatePostErrorState());
    //
    // }
    //"/data/user/0/com.example.fue_got_talent/cache/image_picker1831505106699694295.jpg"
    emit(SocialCreatePostLoadingState());
    // myVideosDocs = await FirebaseFirestore.instance.collection('posts')
    //     .doc(userModel!.uid)
    //     .collection('userVideos')
    //     .get();
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('videos/${Uri.file(postVideo!.path).pathSegments.last}')
        .putFile(await _compressVideo(postVideoPath!))
        .then((value) {
      value.ref.getDownloadURL().then((value)
       async {
         String videoThumbnail = await _uploadImageToStorage(postVideoPath!);
         print(value);
        // emit(SocialCreatePostLoadingState());
          Video model = Video(
            name:userModel!.name,
            uid: userModel!.uid,
            ratings: {},
            commentCount: 0,
            dateTime: DateTime.now(),
            description: description,
            image: userModel!.image,
            postVideo: value,
            thumbnail: videoThumbnail,
            category: category,
            ratingCount: 0,
            form:form,
          );
        FirebaseFirestore.instance
            .collection('posts')
            .add(model.toMap())
            .then((value)
        {
          emit(SocialCreatePostSuccessState());
        }).catchError((error)
        {
          emit(SocialCreatePostErrorState());
        });

      }).catchError((error) {
        print(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }




  // void uploadPostImage({required String dateTime, required String description,})
  // {
  //   //"/data/user/0/com.example.fue_got_talent/cache/image_picker1831505106699694295.jpg"
  //   emit(SocialCreatePostLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
  //       .putFile(postImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //       createPost(
  //           description: description,
  //           dateTime: dateTime,
  //           postVid: value,
  //       );
  //
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit(SocialCreatePostErrorState());
  //     });
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialCreatePostErrorState());
  //   });
  // }


  // void createPost({required String description, required String dateTime, String? postVid})
  // {
  //   emit(SocialCreatePostLoadingState());
  //   PostModel model = PostModel(
  //     name: userModel!.name,
  //     uid: userModel!.uid,
  //     image: userModel!.image,
  //     dateTime: dateTime,
  //     description: description,
  //     postVideo: postVid,
  //   );
  //   FirebaseFirestore.instance.collection('posts')
  //       .add(model.toMap()).then((value)
  //   {
  //     emit(SocialCreatePostSuccessState());
  //   }).catchError((error)
  //   {
  //     emit(SocialCreatePostErrorState());
  //   });
  // }
  List <Video> videos = [];
  List <String> videosID = [];
  List <int> likes = [];
  int myVideosCount = 0;
  List <Video> myVideos = [];
  List <String> myVideosID = [];
  List <int> commentsCount = [];

  // void getProfilePosts()
  // async {
  //   SocialGetProfilePostsLoadingState();
  //    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts')
  //   .doc(userModel!.uid)
  //   .collection('userVideos')
  //   .orderBy("dateTime", descending: true)
  //   .get();
  //    emit(SocialGetProfilePostsSuccessState());
  //    myPostCount = snapshot.docs.length;
  //    myVideos = snapshot.docs.map((doc) => Video.fromDoc(doc)).toList();
  //   // videosID =snapshot.docs
  //   // .then((value)
  //   // {
  //   //   videos = [];
  //   //   value.docs.forEach((element){
  //   //     element.reference.collection('likes').get().then((value){
  //   //         likes.add(value.docs.length);
  //   //         videosID.add(element.id);
  //   //         videos.add(Video.fromJson(element.data()));
  //   //         emit(SocialGetPostsSuccessState());
  //   //
  //   //     }).catchError((error){
  //   //       emit(SocialGetPostsErrorState(error.toString()));
  //   //     });
  //   //   });
  //   //   // emit(SocialGetPostsSuccessState());
  //   // }).catchError((error)
  //   // {
  //   //   emit(SocialGetPostsErrorState(error.toString()));
  //   // });
  // }
  List<int> videosCommentsCount=[];
  void getPosts({String? category}){
    if (category == ' All ')
    {
      emit(SocialGetPostsLoadingState());
      FirebaseFirestore.instance
          .collection('posts')
          // .where('category',isEqualTo: category)
          .orderBy("dateTime", descending: true)
          .get()
          .then((value)
      {
        videos = [];
        videosID = [];
        videosCommentsCount=[];
        value.docs.forEach((element){
          element.reference.collection('comments').get().then((value){
            videosCommentsCount.add(value.docs.length);
            videosID.add(element.id);
            videos.add(Video.fromJson(element.data()));

          }).catchError((error)
          {
            emit(SocialGetPostsErrorState(error.toString()));
          });
        });
        // emit(SocialGetPostsSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(SocialGetPostsErrorState(error.toString()));
      });
    }
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('category',isEqualTo: category)
        // .orderBy("dateTime", descending: true)
        .get()
        .then((value)
    {
      videos = [];
      videosID = [];
      videosCommentsCount=[];
      value.docs.forEach((element){
        element.reference.collection('comments').get().then((value){
          videosCommentsCount.add(value.docs.length);
          videosID.add(element.id);
          videos.add(Video.fromJson(element.data()));

        }).catchError((error)
        {
          emit(SocialGetPostsErrorState(error.toString()));
        });
      });
      // emit(SocialGetPostsSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });

  }

  List<int> myVideosCommentsCount=[];
  void getProfilePostsNew(){
    emit(SocialGetProfilePostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('uid',isEqualTo: userModel!.uid)
        .get()
        .then((value)
    {
      myVideos = [];
      myVideosID=[];
      myVideosCommentsCount=[];
      myVideosCount = value.docs.length;
      value.docs.forEach((element){
        element.reference.collection('comments').get().then((value)
        {

          myVideosCommentsCount.add(value.docs.length);
          myVideosID.add(element.id);
          myVideos.add(Video.fromJson(element.data()));
          emit(SocialGetProfilePostsSuccessState());

        }
        ).catchError((error){
          emit(SocialGetProfilePostsErrorState(error.toString()));
        });
      });
    }).catchError((error)
    {
      emit(SocialGetProfilePostsErrorState(error.toString()));
    });

  }
  // void getProfilePosts(){
  //   emit(SocialGetProfilePostsLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(userModel!.uid)
  //       .collection('userVideos')
  //       .orderBy("dateTime", descending: true)
  //       .get()
  //       .then((value)
  //   {
  //     myVideos = [];
  //     myVideosCount = value.docs.length;
  //     value.docs.forEach((element){
  //       element.reference.collection('comments').get().then((value)
  //       {
  //
  //         myVideosComments.add(value.docs.length);
  //         myVideosID.add(element.id);
  //         myVideos.add(Video.fromJson(element.data()));
  //         emit(SocialGetProfilePostsSuccessState());
  //
  //       }
  //       ).catchError((error){
  //         emit(SocialGetProfilePostsErrorState(error.toString()));
  //       });
  //     });
  //   }).catchError((error)
  //   {
  //     emit(SocialGetProfilePostsErrorState(error.toString()));
  //   });
  //
  // }

  List<String> newUsersID = [];
  List<Video> newVideos=[];
  List<int> newVideosComments=[];
  List<String> newVideosID=[];

  void getUser(){

    FirebaseFirestore.instance.collection('users').get()
    .then((value)
    {
      newUsersID = [];
      value.docs.forEach((element){
        newUsersID.add(element.id);
        // users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialUsersGetSearchSuccessState());
    });
  }
  // void getPosts1()
  // {
  //   emit(SocialGetPostsLoadingState());
  //   newUsersID.forEach((element) {
  //     FirebaseFirestore.instance.collection('posts')
  //         .doc(element)
  //         .collection('userVideos')
  //         .orderBy("dateTime", descending: true)
  //         .get()
  //         .then((value) {
  //       value.docs.forEach((element) {
  //         newVideos.add(Video.fromJson(element.data()));
  //       });
  //     });
  //   });
  // }

  // void likePost(String postId)
  // {
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('likes')
  //       .doc(userModel!.uid)
  //       .set({'like':true})
  //       .then((value)
  //   {
  //     emit(SocialLikePostSuccessState());
  //   }).catchError((error)
  //   {
  //     emit(SocialLikePostErrorState(error.toString()));
  //   });
  // }

  void ratePost({required String postId,required double rating,})
  {
    RatingModel model = RatingModel(
        username: userModel!.name!,
      rating: rating
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('ratings')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialRatePostSuccessState());
    }).catchError((error)
    {
      emit(SocialRatePostErrorState(error.toString()));
    });
  }

  void createComment({required String commentText, String? postId})
  {
    emit(SocialCreateCommentLoadingState());
    CommentModel model = CommentModel(
      name: userModel!.name,
      uid: userModel!.uid,
      dateTime: DateTime.now(),
      text: commentText,
      image: userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value)
    {

      emit(SocialCreateCommentSuccessState());
    }).catchError((error) {
      emit(SocialCreateCommentErrorState());
    });
  }

  List<CommentModel> postComments=[];
  List <String> postCommentsID = [];

  void getPostComments(String? postId,String? uid)async
  {
    // emit(SocialGetPostCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy("dateTime", descending: true)
        .get()
        .then((value)
    {
      postComments = [];
      postCommentsID=[];
      value.docs.forEach((element){
        // element.reference.collection('likes').get().then((value){
        //   likes.add(value.docs.length);
          postCommentsID.add(element.id);
          postComments.add(CommentModel.fromJson(element.data()));
          emit(SocialGetPostCommentsSuccessState());

        // })
        //     .catchError((error){
        //   emit(SocialGetPostCommentsErrorState(error.toString()));
        // });
      });
    }).catchError((error)
    {
      emit(SocialGetPostCommentsErrorState(error.toString()));
    });

  }


  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      videos = [];
      myVideos=[];
      videosID = [];
      likes = [];
      // profileImage = null;
      // userModel = null;
      uid = '';
      token='';
      CacheHelper.removeData(key: 'uid');
      CacheHelper.removeData(key: 'token');
      currentIndex = 0;
      emit(SocialLogOutSuccessState());
    }).catchError((error) {
      emit(SocialLogOutErrorState(error.toString()));
    });
  }
  // void listenAuth() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });
  // }
  //-----------------------------
  // bool isDark = false;
  // void changeAppMode({bool? fromShared})
  // {
  //   if(fromShared != null)
  //   {
  //     isDark = fromShared;
  //     emit(SocialChangeModeState());
  //   }
  //   else
  //   {
  //     isDark = !isDark;
  //     CacheHelper.saveData(key:'isDark', value: isDark).then((value)
  //     {
  //       emit(SocialChangeModeState());
  //     });
  //   }
  // }

  List<SocialUserModel> users =[];
  List <String> usersID = [];

  void getSearch(String value)
  {
    emit(SocialUsersGetSearchLoadingState());
    FirebaseFirestore.instance.collection('users')
    .where('name',isGreaterThanOrEqualTo: value)
    .get()
    .then((value)
    {
      users = [];
      usersID = [];
      value.docs.forEach((element){
        usersID.add(element.id);
        users.add(SocialUserModel.fromJson(element.data()));

      });
      // search = value.data['articles'];
      // search = value.data['articles'];
      // print(search[0]['title']);
      emit(SocialUsersGetSearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialUsersGetSearchErrorState(error.toString()));
    });

  }
}
