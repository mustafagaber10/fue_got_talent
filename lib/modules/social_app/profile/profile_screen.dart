import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/cubit/states.dart';
import 'package:fue_got_talent/models/social_app/post_model.dart';
import 'package:fue_got_talent/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:fue_got_talent/modules/social_app/feeds/custom_image.dart';
import 'package:fue_got_talent/modules/social_app/new_post/new_post_screen.dart';
import 'package:fue_got_talent/modules/social_app/profile/video_tile.dart';
import 'package:fue_got_talent/modules/social_app/video_details_page/video_details_page1.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/styles/icon_broken.dart';
import 'package:fue_got_talent/shared/time_ago.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String postOrientation = "list";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        dynamic buildProfilePosts()
        {
          if (state is SocialGetProfilePostsLoadingState)
          {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
          else if (SocialCubit.get(context).myVideos.isEmpty)
          {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SvgPicture.asset('assets/images/no_content.svg', height: 260.0),
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
                        "There is No Posts",
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
          // else if (postOrientation == "grid")
          // {
          //   List<GridTile> gridTiles = [];
          //   SocialCubit.get(context).myVideos.forEach((e) {
          //     gridTiles.add(GridTile(child: VideoTile(e,0)));
          //   });
          //   return GridView.count(
          //     padding: EdgeInsets.zero,
          //     crossAxisCount: 3,
          //     childAspectRatio: 1.0,
          //     mainAxisSpacing: 1.5,
          //     crossAxisSpacing: 1.5,
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     children: gridTiles,
          //   );
          // }
          else if (postOrientation == "list")
          {
            return ListView.separated(
              padding: const EdgeInsets.all(0.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: buildFeedItem1(
                      SocialCubit.get(context).myVideos[index], context, index),
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
                child: Divider(thickness: 2.5),
              ),
              itemCount: SocialCubit.get(context).myVideos.length,
            );
          }
        }


        var userModel = SocialCubit.get(context).userModel;
        return ConditionalBuilder(
          condition:
              // SocialCubit.get(context).myVideos.length > 0 &&
              SocialCubit.get(context).userModel != null,
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                return SocialCubit.get(context).getProfilePostsNew();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Container(
                              height: 100.0,
                              // padding: EdgeInsets.only(bottom:20 ),
                              width: double.infinity,

                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.deepPurpleAccent,
                                      Colors.deepPurple,
                                    ]),
                                // color: Colors.deepPurple,
                              ),
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 90.0,
                            backgroundImage:
                            NetworkImage('${userModel!.image}'),

                            // NetworkImage('${userModel!.image}'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${userModel.name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontFamily: 'Jannah',
                                                  fontSize: 19.0),
                                        ),
                                        Text(
                                          '${userModel.bio}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                fontFamily: 'Jannah',
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${SocialCubit.get(context).myVideosCount}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  fontFamily: 'Jannah',
                                                  fontSize: 19.0),
                                        ),
                                        Text(
                                          'Videos',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontFamily: 'Jannah',
                                                  fontSize: 12.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    navigateTo(context, NewPostScreen());
                                  },
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.all<double>(0.0),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.deepPurpleAccent),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          color: Colors.deepPurpleAccent),
                                    )),
                                  ),
                                  child: const Text('Add Video'),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () {
                                  navigateTo(context, EditProfileScreen());
                                },
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(80.0)),
                                // padding: const EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.deepPurple,
                                          Colors.deepPurpleAccent
                                        ]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        minWidth: 88.0,
                                        minHeight:
                                            36.0), // min sizes for Material buttons
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          IconBroken.Edit_Square,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                          const SizedBox(height: 15),
                          // buildTogglePostOrientation(),
                          // Row(
                          //   children:  [
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(bottom: 15.0),
                          //         child: Divider(
                          //           height: 0,
                          //           // indent: 20,
                          //           // endIndent: 20,
                          //           thickness: 2,
                          //           color: postOrientation == 'grid'
                          //               ? const Color(0xFF6200EA)
                          //               : Colors.grey,                                  ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(bottom: 15.0),
                          //         child: Divider(
                          //           height: 0,
                          //           // indent: 20,
                          //           // endIndent: 20,
                          //           thickness: 2,
                          //           color: postOrientation == 'list'
                          //               ? const Color(0xFF6200EA)
                          //               : Colors.grey,                                ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          buildProfilePosts(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFeedItem1(Video video, context, index) {
    return Card(
      surfaceTintColor: Colors.black,
      color: Theme.of(context).scaffoldBackgroundColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0))),
      elevation: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              SocialCubit.get(context).getPostComments(
                  SocialCubit.get(context).myVideosID[index],
                  video.uid
              );
              navigateTo(context, ChewieDemo(video: video,index:index));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(video.thumbnail.toString()),
                  // Image.network(
                  //   '${model.thumbnail}',
                  //   // fit: BoxFit.cover,
                  // ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black12,
                    child: const Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.black45,
                        radius: 35.0,
                        child: Icon(
                          FontAwesomeIcons.play,
                          color: Colors.white70,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 30.0,
                  backgroundImage:
                  NetworkImage('${video.image}'),
                  // NetworkImage('${video.image}'),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${video.name}',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontFamily: 'Jannah',
                          height: 1.2,
                        ),
                      ),
                      Text(
                        '${video.description}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              height: 1.3,
                            ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    IconBroken.Time_Circle,
                                    color: Colors.deepPurple,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    TimeAgo.timeAgoSinceDate(
                                        video.dateTime?.toDate()),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,

                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          fontSize: 10.0,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          height: 1.3,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            color: Colors.deepPurple,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).myVideosCommentsCount[index]} Comment',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 12.0,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      height: 1.6,
                                    ),
                          ),
                        ],
                      )
                      // Text(
                      //   TimeAgo.timeAgoSinceDate(model.dateTime?.toDate()),
                      //   // model.dateTime.toDate().toString(),
                      //   style: Theme.of(context).textTheme.caption!.copyWith(
                      //         color:
                      //             Theme.of(context).textTheme.bodyText1!.color,
                      //         height: 1.3,
                      //       ),
                      // ),
                      // Text(
                      //   '${model.ratingCount} Comments',
                      //   style: Theme.of(context).textTheme.caption,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 0.0,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 20.0,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
