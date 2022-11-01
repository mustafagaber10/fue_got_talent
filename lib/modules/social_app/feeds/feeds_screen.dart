import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/cubit/states.dart';
import 'package:fue_got_talent/models/social_app/post_model.dart';
import 'package:fue_got_talent/modules/social_app/feeds/custom_image.dart';
import 'package:fue_got_talent/modules/social_app/video_details_page/video_details_page1.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/time_ago.dart';
import '../../../shared/styles/icon_broken.dart';

class FeedsScreen extends StatefulWidget {
  static List<String> categories = [
    " All",
    "FootBall",
    "Music",
    "Singing"
  ];

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).videos.length > 0 &&
              SocialCubit.get(context).userModel != null,
          builder: (context) => RefreshIndicator(
            onRefresh: () async {
              return SocialCubit.get(context).getPosts();
            },
            child: ListView(
              children: [
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 0.0, right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              // top: 8.0,
                              left: 4.0),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontFamily: 'Jannah',
                                letterSpacing: 0.3,
                                height: 1.0),
                          ),
                        ),
                        const SizedBox(height: 8.0),

                        SizedBox(
                          width: double.infinity,
                          height: 45.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: FeedsScreen.categories
                                .map((e) => Container(
                                    margin: const EdgeInsets.only(right: 12.0),
                                    child: FilterChip(
                                          label: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                                fontFamily: 'Jannah'),
                                          ),
                                        ),
                                        onSelected: (value)
                                        {
                                          SocialCubit.get(context).getPosts(category: e);
                                        }
                                        )))
                                .toList(),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(thickness: 2.5),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.separated(
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
                          SocialCubit.get(context).videos[index],
                          // SocialCubit.get(context).postComments,
                          context,
                          index),
                    );
                  },
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal:  30.0,vertical: 12),
                    child: Divider(thickness: 2.5),
                  ),
                  itemCount: SocialCubit.get(context).videos.length,
                ),
                const SizedBox(height: 50,width: double.infinity,)
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFeedItem1(
      Video model,
      // List<CommentModel> comments,
      context,
      index
      )
  {
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
                  SocialCubit.get(context).videosID[index],
                  model.uid
              );
              navigateTo(context, ChewieDemo(video: model,index:index));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child:
                    cashedNetworkImage(model.thumbnail.toString()),
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
                        child:  Icon(
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
                  NetworkImage('${model.image}'),
                  // NetworkImage('${model.image}'),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.name}',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontFamily: 'Jannah',
                          height: 1.2,
                        ),
                      ),
                      Text(
                        '${model.description}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          height: 1.3,

                        ),
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                        [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    IconBroken.Time_Circle,
                                    color: Colors.deepPurple,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 5.0,),
                                  Text(
                                    TimeAgo.timeAgoSinceDate(model.dateTime?.toDate()),
                                    style: Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 12.0,
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 35,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                        [
                          const Icon(
                            IconBroken.Chat,
                            color: Colors.deepPurple,
                            size: 18,
                          ),

                          const SizedBox(width: 5.0,),
                          Text(
                            '${SocialCubit.get(context).videosCommentsCount[index]} Comment',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 12.0,
                              color: Theme.of(context).textTheme.bodyText1!.color,
                              height: 1.6,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 25.0,
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
