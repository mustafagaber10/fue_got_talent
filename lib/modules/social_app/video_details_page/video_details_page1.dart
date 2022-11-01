// import 'package:flutter/material.dart';
// import 'package:fue_got_talent/models/social_app/post_model.dart';
// import 'package:video_player/video_player.dart';
//
// import 'chewie_list_item.dart';
//
// class VideoDetailsScreen extends StatelessWidget {
//   final Video model;
//   VideoDetailsScreen({Key? key, required this.model}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     //   late VideoPlayerController _controller;
//
//     return Scaffold(
//     appBar: AppBar(
//
//       title: Text(model.description!),
//     ),
//     body: ListView(
//       children: <Widget>[
//         ChewieListItem(
//           videoPlayerController: VideoPlayerController.network(model.postVideo!),
//         ),
//
//       ],
//     ),
//   );
//   }
//
//
// }
//

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/cubit/states.dart';
import 'package:fue_got_talent/models/social_app/comment_model.dart';
import 'package:fue_got_talent/models/social_app/post_model.dart';
import 'package:fue_got_talent/models/social_app/rating_model.dart';
import 'package:fue_got_talent/modules/social_app/feeds/custom_image.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/styles/icon_broken.dart';
import 'package:fue_got_talent/shared/time_ago.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:video_player/video_player.dart';

class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    Key? key,
    required this.video,
    required this.index,
  }) : super(key: key);
  final int index;
  final Video video;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  TextEditingController commentController = TextEditingController();
  var _ratingController = TextEditingController();
  double _userRating = 0;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    _ratingController.text = '4.5';
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(widget.video.postVideo!);
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: false,
      hideControlsTimer: const Duration(seconds: 1),
      placeholder: Container(
        color: Colors.black87,
      ),
      autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<CommentModel> comments = SocialCubit.get(context).postComments;
        buildComments() {

          if (state is SocialGetPostCommentsLoadingState)
          {
            return const Center(child: CircularProgressIndicator());
          }
          else
          if (SocialCubit.get(context).postComments.isEmpty)
          {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 55.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.error,
                        color: Colors.deepPurpleAccent,
                        size: 45,
                      ),
                      Text(
                        "There is No Comments",
                        // softWrap: false,
                        maxLines: 3,
                        style: TextStyle(
                          fontFamily: 'Jannah',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            child: ListView.separated(
              padding: const EdgeInsets.all(0.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(2, 2),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      const BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-2, -2),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 85,
                  child: Column(
                    children: [
                      Row(
                        children: [
                           Padding(
                            padding: EdgeInsets.only(top: 10,left: 7.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  CachedNetworkImageProvider(comments[index].image.toString()),
                              // NetworkImage(comments[index].image.toString()),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:  [
                                      Text(
                                        comments[index].name.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        comments[index].text.toString(),
                                        style: TextStyle(fontSize: 16.0),
                                        maxLines: 5,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            IconBroken.Time_Circle,
                                            color: Colors.deepPurple,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 5.0,),
                                          Text(
                                            TimeAgo.timeAgoSinceDate(comments[index].dateTime?.toDate()),
                                            style: Theme.of(context).textTheme.caption!.copyWith(
                                              fontSize: 12.0,
                                              color: Theme.of(context).textTheme.bodyText1!.color,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1.5),
              itemCount: comments.length,
            ),
          );
        }

        return Scaffold(
          // backgroundColor:Colors.black87,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(

                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.deepPurpleAccent,
                      Colors.deepPurple,
                    ]),
              ),
            ),
            title: Text(widget.video.category.toString()),
          ),
          body: ConditionalBuilder(
            condition: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized,
            builder: (context) => SafeArea(
              bottom: true,
              child: Column(

                children: [
                  Center(
                      child: AspectRatio(
                          aspectRatio:
                              // _chewieController!.videoPlayerController.value.aspectRatio,
                              16 / 9,
                          child: Chewie(
                            controller: _chewieController!,
                          ))
                  ),
                  // SizedBox(height: 100,
                  //   child:StreamBuilder(
                  //     stream: FirebaseFirestore.instance.collection('posts')
                  //         .doc(SocialCubit.get(context).videosID[widget.index])
                  //         .collection('ratings')
                  //         .snapshots(),
                  //     builder: (context,
                  //         AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot)
                  //     {
                  //       if(snapshot.connectionState==ConnectionState.waiting)
                  //       {
                  //         return Center(child: CircularProgressIndicator());
                  //       }else{
                  //         return ListView.builder(
                  //             itemCount: snapshot.data!.docs.length,
                  //             itemBuilder:(context,index){
                  //               RatingModel model= RatingModel.getModelFromJson(json: snapshot.data!.docs[index].data());
                  //               return ratingWidget(model:model);
                  //             }
                  //         );
                  //       }
                  //     },
                  //   ) ,
                  // ),
                  Expanded(
                    child:
                    RefreshIndicator(
                      onRefresh: () async {
                        return SocialCubit.get(context).getPostComments(
                            SocialCubit.get(context).videosID[widget.index],
                            widget.video.uid);
                      },

                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                          children:
                          [
                           if(widget.video.uid==SocialCubit.get(context).userModel!.uid!)
                            Row(
                               children: const [
                                 Padding(
                                   padding: EdgeInsets.only(top: 20.0, left: 10.0,bottom: 5),
                                   child: Text(
                                     'Ratings',
                                     style: TextStyle(
                                         fontSize: 22.0,
                                         fontFamily: 'Jannah',
                                         letterSpacing: 0.3,
                                         height: 1.0),
                                   ),
                                 ),
                               ],
                             ),
                           if(widget.video.uid==SocialCubit.get(context).userModel!.uid!)
                             myDivider(),
                           if(widget.video.uid==SocialCubit.get(context).userModel!.uid!)
                             SizedBox(
                              height: 100,
                              child:StreamBuilder(
                                stream:
                                    FirebaseFirestore.instance.collection('posts')
                                    .doc(SocialCubit.get(context).videosID[widget.index])
                                    .collection('ratings')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot)
                                    {
                                      if(snapshot.connectionState==ConnectionState.waiting)
                                      {
                                        return Container();
                                      }else{
                                        return ListView.builder(
                                            itemCount: snapshot.data!.docs.length,
                                            itemBuilder:(context,index){
                                              RatingModel model= RatingModel.getModelFromJson(json: snapshot.data!.docs[index].data());
                                              return ratingWidget(model:model);
                                            }
                                        );
                                      }
                                    },
                              ) ,
                            ),
                           if(widget.video.uid!=SocialCubit.get(context).userModel!.uid)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GFRating(
                                value: _userRating,
                                showTextForm: true,
                                controller: _ratingController,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8.5),
                                  child: GFButton(
                                    color: Colors.deepPurple.shade500,
                                    size: GFSize.LARGE,
                                    type: GFButtonType.solid,
                                    onPressed: () {
                                      setState(() {
                                        _userRating = double.parse(_ratingController.text);
                                        SocialCubit.get(context).ratePost(postId: SocialCubit.get(context)
                                            .videosID[widget.index],
                                            rating: _userRating);
                                      });
                                    },
                                    child: const Text('Rate'),
                                  ),
                                ),
                                onChanged: (double rating) {},
                              ),
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0, left: 25.0),
                                  child: Text(
                                    'Comments',
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontFamily: 'Jannah',
                                        letterSpacing: 0.3,
                                        height: 1.0),
                                  ),
                                ),
                              ],
                            ),
                            buildComments()
                          ]
                      ),
                    ),
                  ),
                  if(widget.video.uid!=SocialCubit.get(context).userModel!.uid)

                    Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        height: 61,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(35.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: commentController,
                                        decoration: const InputDecoration(
                                            hintText: "Type Something...",
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 3),
                                    blurRadius: 5,
                                    color: Colors.grey,
                                  ),
                                ],
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.send_rounded,
                                  size: 30,
                                  color: Color(0xFF6200EA),
                                ),
                                onPressed: () {
                                  SocialCubit.get(context).createComment(
                                      commentText: commentController.text,
                                      postId: SocialCubit.get(context)
                                          .videosID[widget.index]);

                                  commentController.clear();
                                  print(commentController.text.toString());
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Loading...',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
