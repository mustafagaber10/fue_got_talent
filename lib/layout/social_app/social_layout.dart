import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/cubit/states.dart';
import 'package:fue_got_talent/modules/social_app/new_post/new_post_screen.dart';
import 'package:fue_got_talent/modules/social_app/social_login/social_login_screen.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/styles/icon_broken.dart';

import '../../modules/social_app/search/search_screen.dart';

var tstyle = TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 50);

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          body: NestedScrollView(

            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                PreferredSize(
                  preferredSize:  const Size.fromHeight(0),
                  child: SliverAppBar(
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
                    toolbarHeight: 75,
                    // collapsedHeight: 90,
                    pinned: true,
                    snap: true,
                    leading: Builder(
                      builder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/menu.svg',
                            height: 15,
                            width: 34,
                            color: Colors.white,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        ),
                      ),
                    ),
                    title: Text(
                      cubit.titles[cubit.currentIndex],
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    floating: true,
                    expandedHeight: 75.0,
                    forceElevated: innerBoxIsScrolled,
                    actions: [
                      IconButton(
                          onPressed: () {
                            // navigateTo(context, SearchScreen());
                          },
                          icon: const Icon(
                            IconBroken.Notification,
                          )),
                      IconButton(
                          onPressed: () {
                            navigateTo(context, SocialSearchScreen());
                          },
                          icon: const Icon(
                            IconBroken.Search,
                          )),
                    ],
                    // shape: const RoundedRectangleBorder(
                    //     // side:BorderSide(width: 1,color: Colors.transparent,style:BorderStyle.none ) ,
                    //     borderRadius: BorderRadius.only(
                    //         bottomLeft: Radius.circular(30),
                    //         bottomRight: Radius.circular(30))),
                  ),
                ),
              ];
            },
            body: cubit.screens[cubit.currentIndex],
          ),
          backgroundColor: Colors.white,
          // extendBody: false,
          extendBodyBehindAppBar: true,
          // appBar: PreferredSize(
          //   preferredSize: const Size.fromHeight(80.0),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 8.0),
          //     child: AppBar(
          //       leading: Builder(
          //         builder: (BuildContext context) => Padding(
          //           padding: const EdgeInsets.only(left: 8.0),
          //           child: IconButton(
          //               icon: SvgPicture.asset('assets/icons/menu.svg',
          //                 height: 15,
          //                 width: 34,
          //                 color: Colors.white,
          //               ),
          //               onPressed: () => Scaffold.of(context).openDrawer(),
          //               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          //             ),
          //         ),
          //       ),
          //       title: Text(
          //         cubit.titles[cubit.currentIndex],
          //         style: Theme.of(context).appBarTheme.titleTextStyle,
          //       ),
          //       actions: [
          //         IconButton(
          //             onPressed: () {
          //               // navigateTo(context, SearchScreen());
          //             },
          //             icon: const Icon(
          //               IconBroken.Notification,
          //             )),
          //         IconButton(
          //             onPressed: () {
          //               // navigateTo(context, SearchScreen());
          //             },
          //             icon: const Icon(
          //               IconBroken.Search,
          //             )),
          //       ],
          //       shape: const RoundedRectangleBorder(
          //         // side:BorderSide(width: 1,color: Colors.transparent,style:BorderStyle.none ) ,
          //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
          //       ),
          //     ),
          //   ),
          // ),
          drawer: Drawer(
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    SocialCubit.get(context).changeBottomNav(2);
                  },
                  child: UserAccountsDrawerHeader(
                    onDetailsPressed: () {
                      Navigator.pop(context);
                      SocialCubit.get(context).changeBottomNav(2);

                    },
                    arrowColor: Colors.white,
                    accountName: Text('${cubit.userModel?.name}',
                        style: const TextStyle(
                          height: 3,
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    accountEmail: Text('${cubit.userModel?.email}',
                        style: const TextStyle(
                          height: 0,
                        fontSize: 14, fontWeight: FontWeight.w500)),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          '${cubit.userModel?.image}',
                          // NetworkImage(
                          //   '${userModel!.image}'
                          // color: Colors.white,

                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      // color: Colors.deepPurple,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end:Alignment.centerRight,
                            colors: [Colors.deepPurpleAccent,
                              Colors.deepPurple,
                            ]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),

                ListTile(
                  leading: const Icon(
                    IconBroken.Home,
                    color: Colors.deepPurple,
                  ),
                  title: const Text('Home',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: Colors.deepPurple,
                  ),
                  title: const Text('Settings',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.deepPurple,
                  ),
                  // leading: SvgPicture.asset("assets/icons/user-icon.svg",color: Colors.black,),
                  title: const Text('Theme',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.policy_outlined,
                    color: Colors.deepPurple,
                  ),
                  title: const Text('Policies',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.share_outlined,
                    color: Colors.deepPurple,
                  ),
                  title: const Text('Share',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                const Divider(),
                const Spacer(),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.logout_rounded,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                  title: const Text('Logout',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  onTap: () async {

                    await cubit.logOut();
                    Navigator.pop(context);
                    navigateAndFinish(context, SocialLoginScreen());

                  },
                ),
                const SizedBox(height: 15,)
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(

            tooltip: "Add Video",
            onPressed: ()=>cubit.changeBottomNav(1),
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end:Alignment.centerRight,
                    colors: [Colors.deepPurpleAccent,
                      Colors.deepPurple,
                    ]),
              ),
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // extendBody: true,
          // bottomNavigationBar: Theme(
          //   data: Theme.of(context).copyWith(
          //     iconTheme: const IconThemeData(
          //         size: 29,
          //         color: Colors.white
          //     ),
          //
          //   ),
          //   child: CurvedNavigationBar(
          //
          //     key: cubit.navigationKey,
          //     index: cubit.currentIndex, // animationDuration: Duration(milliseconds: 450),
          //     color: Colors.deepPurple.withOpacity(0.9),
          //     // buttonBackgroundColor: Colors.grey,
          //     height: 50,
          //     backgroundColor: Colors.white.withOpacity(0.8),
          //     items: const <Widget>[
          //       Padding(
          //         padding: EdgeInsets.all(5.0),
          //         child: Icon(
          //           IconBroken.Home,
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.all(5.0),
          //         child: Icon(
          //           IconBroken.Play,size: 40,
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.all(5.0),
          //         child: Icon(
          //           IconBroken.Profile,
          //         ),
          //       ),
          //     ],
          //     onTap: (index) {
          //       cubit.changeBottomNav(index);
          //     },
          //
          //   ),
          // ),
          bottomNavigationBar: BottomAppBar(
              elevation: 50,
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                // padding: const EdgeInsets.symmetric(horizontal: 60),
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                        child: IconButton(
                          onPressed: ()=>cubit.changeBottomNav(0),
                          icon: const Icon(
                            IconBroken.Home,
                            size: 30,
                            color: Color(0xFF6200EA),
                          ),
                        )
                    ),                    const SizedBox.shrink(),
                    Expanded(
                        child: IconButton(
                        onPressed: ()=>cubit.changeBottomNav(2),
                        icon: const FaIcon(
                          IconBroken.Profile,
                          size: 30,
                          color: Color(0xFF6200EA),
                        ),
                      )
                    ),
                  ],
                ),
              )
          ),

          // bottomNavigationBar: BottomNavigationBar(
          //   elevation: 5,
          //   currentIndex: cubit.currentIndex,
          //   onTap: (index) {
          //     cubit.changeBottomNav(index);
          //   },
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(
          //         IconBroken.Home,
          //       ),
          //       label: 'Home',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(
          //         IconBroken.Upload,
          //       ),
          //       label: "add",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(
          //         IconBroken.User,
          //       ),
          //       label: 'Settings',
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
