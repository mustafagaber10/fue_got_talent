import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/cubit/states.dart';
import 'package:fue_got_talent/models/social_app/social_user_model.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/styles/icon_broken.dart';

class SocialSearchScreen extends StatelessWidget
{

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state)
      {

      },
      builder: (context,state)
      {
        List<SocialUserModel> list = SocialCubit.get(context).users;
        return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(IconBroken.Arrow___Left_2),
          ),
          title: Text('Search about Users',
          ),
          toolbarHeight: 70,
          flexibleSpace: Container(
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(25),
            //     bottomRight: Radius.circular(25),
            // ),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end:Alignment.centerRight,
                colors: [Colors.deepPurpleAccent,
                  Colors.deepPurple,
                ]),
          ),
        ),

        ),
        body: Column(
          children:
          [

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                controller: searchController,
                type: TextInputType.text,
                onChange: (value)
                {
                  SocialCubit.get(context).getSearch(value!);
                },
                validate: (value)
                {
                  if(value.isEmpty)
                  {
                    return 'search must not be empty';
                  }
                  return null;
                },
                label: 'Search',
                prefix: Icons.search,
              ),
            ),
            Expanded(child: searchBuilder(list, context)),
          ],
        ),
      );
     },
    );
  }
  Widget buildSearchItem(SocialUserModel user, context) => InkWell(
    onTap: () {
      // navigateTo(context, webViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
                image: CachedNetworkImageProvider(user.image.toString()),
                // NetworkImage(user.image.toString()),
                fit: BoxFit.cover),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${user.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${user.bio}',
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    ),
  );
  Widget searchBuilder(list, context) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildSearchItem(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: list.length,
    ),
    fallback: (context) => const Center(child: CircularProgressIndicator()),
  );

}
