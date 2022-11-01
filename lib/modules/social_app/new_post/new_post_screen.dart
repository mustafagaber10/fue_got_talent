import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/cubit/states.dart';
import 'package:fue_got_talent/modules/social_app/new_post/footballform.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/styles/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../video_details_page/chewie_list_item.dart';
import 'form.dart';

String? dropdownValue ;
bool checked = false;
class NewPostScreen extends StatefulWidget
{
  Map<String,String>? form ;
  NewPostScreen({this.form});
  // NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState(form: form);
}

class _NewPostScreenState extends State<NewPostScreen> {
  Map<String,String>? form ;
  _NewPostScreenState({this.form});
  TextEditingController postController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dropdownValue=null;
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){
        if (state is SocialCreatePostSuccessState)
        {
          SocialCubit.get(context).removePostVideo();
          showToast(msg: "Uploaded !", state: ToastStates.SUCCESS);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state)
      {

        var userModel = SocialCubit.get(context).userModel;


        return Scaffold(
            appBar: AppBar(
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
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              leading:
                IconButton(
                  onPressed: (){
                    if(SocialCubit.get(context).postVideo!=null)
                    {
                      SocialCubit.get(context).removePostVideo();
                    }
                    // final navigationState = SocialCubit.get(context).navigationKey.currentState!;
                    // navigationState.setPage(0);
                    Navigator.of(context).pop();

                  },
                  icon: const Icon(IconBroken.Arrow___Left_2),
                ),
              titleSpacing: 5.0,
              title: const Text('Add Your Video'),
              actions:
                [
                  TextButton(
                      onPressed: ()
                      {
                        if(SocialCubit.get(context).postVideo == null)
                        {
                          showToast(msg: "Please Choose Video", state: ToastStates.ERROR);
                        }else if (postController.text==null||postController.text=='')
                        {
                          showToast(msg: "Please Write Description ", state: ToastStates.ERROR);
                        }
                        else if(dropdownValue == null)
                        {
                          showToast(msg: "Please Select Category", state: ToastStates.ERROR);
                        }
                        else
                        {
                          SocialCubit.get(context).uploadPost(
                              description: postController.text,
                              category: dropdownValue!,
                              form: SocialCubit.get(context).form!,
                          );
                        }
                      },
                      child:
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text ('Post'.toUpperCase(), style: const TextStyle(color: Colors.white),),
                      ),

                  ),
                ],
              shape: const RoundedRectangleBorder(
                // side:BorderSide(width: 1,color: Colors.transparent,style:BorderStyle.none ) ,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
              ),
            ),

          // appBar: defaultAppBar(
          //   leadingWidget: IconButton(
          //     onPressed: (){
          //       Navigator.pop(context);
          //       // final navigationState = SocialCubit.get(context).navigationKey.currentState!;
          //       // navigationState.setPage(0);
          //     },
          //     icon: const Icon(IconBroken.Arrow___Left_2),
          //   ),
          //   context: context,
          //   title: 'Create Post',
          //   actions:
          //   [
          //     TextButton(
          //         onPressed: ()
          //         {
          //           if(SocialCubit.get(context).postVideo == null)
          //           {
          //             showToast(msg: "Please Choose Video", state: ToastStates.ERROR);
          //           }else if(dropdownValue == null)
          //           {
          //             showToast(msg: "Please Select Category", state: ToastStates.ERROR);
          //           }
          //           else
          //           {
          //             SocialCubit.get(context).uploadPost(description: postController.text,dateTime: DateTime.now().toString(), category: dropdownValue!);
          //           }
          //         },
          //         child:
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //           child: Text ('Post'.toUpperCase(), style: const TextStyle(color: Colors.white),),
          //         ),
          //
          //     ),
          //   ],
          // ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(

                children:
                [
                  if(state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  // if(state is SocialCreatePostLoadingState)
                  //   buildProgress(),
                  if(state is SocialCreatePostLoadingState)
                    const SizedBox(height: 10.0),
                  Row(
                    children:
                    [
                       CircleAvatar(
                        radius: 30.0,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage('${userModel!.image}'),
                      ),
                      const SizedBox(width: 18.0,),
                      Expanded(
                        child: Text(
                          '${SocialCubit.get(context).userModel!.name}',
                          style: TextStyle(
                            // color: Colors.red,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontFamily: 'Jannah',
                            fontSize: 18.0,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: TextFormField(
                            validator: (value)
                            {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            maxLength: 100,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            controller: postController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: 'What is on your mind ...',
                              hintStyle: TextStyle(
                                fontFamily: 'Jannah',
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  if(SocialCubit.get(context).postVideo!=null)
                    Expanded(
                      flex: 20,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child:
                                // Chewie(
                                //     controller: ChewieController(
                                //       aspectRatio: SocialCubit.get(context).controller!.value.aspectRatio,
                                //       videoPlayerController: SocialCubit.get(context).controller!,
                                //       autoInitialize: true,
                                //
                                //     ),
                                // ),
                              ChewieListItem(videoPlayerController: SocialCubit.get(context).controller!,),
                            ),
                          ),
                          IconButton(
                            onPressed: ()
                            {
                              SocialCubit.get(context).removePostVideo();

                            },
                            icon: CircleAvatar(
                              backgroundColor: Colors.grey.shade600,
                              radius: 20.0,
                              child: const Icon(
                                Icons.close,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 10.0),
                    Row(
                    children:
                    [
                      if(SocialCubit.get(context).postVideo==null)
                        Expanded(
                        child:
                        TextButton(
                          onPressed: ()
                          {
                            showOptionDialog(BuildContext context){
                              return showDialog(
                                  context: context,
                                  builder: (context)=>SimpleDialog(
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                    children: [
                                      const SizedBox(height: 12,),
                                      SimpleDialogOption(
                                        onPressed: ()=>SocialCubit.get(context).getPostVideo(ImageSource.gallery,context),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.image),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Text('Gallery',style: TextStyle(fontSize: 20),),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12,),
                                      SimpleDialogOption(
                                        onPressed: ()=>SocialCubit.get(context).getPostVideo(ImageSource.camera,context),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.camera_alt_rounded),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Text('Camera',style: TextStyle(fontSize: 20),),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12,),
                                      SimpleDialogOption(
                                        onPressed: ()=>Navigator.of(context).pop(),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.cancel_rounded),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Text('Cancel',style: TextStyle(fontSize: 20),),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12,),

                                    ],
                                  ));
                            }
                            showOptionDialog(context);
                            // SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            const [
                              Icon(
                                Icons.video_library_rounded,
                              ),
                              SizedBox(width: 7.5),
                              Text('Add Video'),

                            ],
                          ),
                        ),
                        ),
                        Expanded(
                          child: Select_Category_DDB()
                      ),
                    ],
                  ),
                ],
              ),
            ),

        );
      },
    );
  }
}
class Select_Category_DDB extends StatefulWidget {
  const Select_Category_DDB({Key? key}) : super(key: key);

  @override
  State<Select_Category_DDB> createState() => _Select_Category_DDB();
}

class _Select_Category_DDB extends State<Select_Category_DDB> {

  @override
  Widget build(BuildContext context) => IgnorePointer(
    ignoring: dropdownValue==null ? false:true,
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
          value: dropdownValue,
          hint:  const Center(
            child:  Text('Select Category',
                style: TextStyle(
                    color:Colors.deepPurple ,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                )
            ),
          ),
          isExpanded: true,
          focusColor: Colors.deepPurple,
          iconEnabledColor: Colors.deepPurple,
          iconDisabledColor: Colors.deepPurple,
          autofocus: true,
          iconSize: 33,
          elevation: 10,
          enableFeedback: true,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          style: const TextStyle(color: Colors.deepPurple,),
          onChanged: (newValue){
            setState(()  {
              // dropdownValue = newValue!;
              dropdownValue = newValue.toString();
              if (dropdownValue== 'Music') {
                print('checked');
                navigateTo(context, Inquiry());

              }else if (dropdownValue == 'FootBall')
              {
                print('checked');
                navigateTo(context, FootballForm());
              }
            });
          },
        // onChanged: null,
          items:[ 'FootBall', 'Music', 'Squash','Singing'].map((e)=>DropdownMenuItem(
              value: e,
              child: Center(child: Text(e,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)),
          )).toList(),


      ),
    ),
  );
}

