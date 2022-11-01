// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
// import 'package:fue_got_talent/shared/styles/icon_broken.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../shared/components/components.dart';
//
// class ConfirmScreen extends StatefulWidget {
//   final File videoFile;
//   final String videoPath;
//   const ConfirmScreen({Key? key, required this.videoFile, required this.videoPath,}) : super(key: key);
//
//   @override
//   State<ConfirmScreen> createState() => ConfirmScreenState();
// }
//
// class ConfirmScreenState extends State<ConfirmScreen> {
//
//   late VideoPlayerController controller;
//   @override
//   void initState(){
//     super.initState();
//     setState((){
//       controller = VideoPlayerController.file(widget.videoFile);
//     });
//     controller.initialize();
//     controller.play();
//     controller.setVolume(0.5);
//     controller.setLooping(true);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: defaultAppBar(
//         leadingWidget: IconButton(
//           onPressed: (){
//             Navigator.pop(context);
//             Navigator.pop(context);
//           },
//           icon: const Icon(IconBroken.Arrow___Left_2),
//         ),
//         context: context,
//         title: 'Create Post',
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height/1.5,
//               child: VideoPlayer(controller),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
