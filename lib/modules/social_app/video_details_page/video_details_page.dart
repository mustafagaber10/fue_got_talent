// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fue_got_talent/models/social_app/post_model.dart';
// import 'package:video_player/video_player.dart';
//
// import 'basic_overlay_widget.dart';
//
// class VideoDetailsScreen extends StatefulWidget {
//   final Video model;
//   const VideoDetailsScreen({Key? key, required this.model}) : super(key: key);
//
//   @override
//   State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
// }
//
// class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
//   late VideoPlayerController _controller;
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.model.postVideo!)
//       ..addListener(() => setState(() {}))
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) =>
//       AnnotatedRegion<SystemUiOverlayStyle>(
//         value: const SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.black,
//           // extendBody: true,
//           // extendBodyBehindAppBar: true,
//           extendBodyBehindAppBar: true,
//           body: ConditionalBuilder(
//             condition: _controller.value.isInitialized,
//             builder: (context) => Center(
//               child: Stack(
//                 children: [
//                   AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: VideoPlayer(_controller),
//                   ),
//                   Positioned.fill(
//                       child: BasicOverlayWidget(controller: _controller))
//                 ],
//               ),
//             ),
//             fallback: (context) => SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: const Center(child: CircularProgressIndicator())),
//           ),
//
//           // floatingActionButton: FloatingActionButton(
//           //   onPressed: () {
//           //     setState(() {
//           //       _controller.value.isPlaying
//           //           ? _controller.pause()
//           //           : _controller.play();
//           //     });
//           //   },
//           //   child: Icon(
//           //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           //     size: 45,
//           //     color: Colors.white70,
//           //   ),
//           // ),
//         ),
//       );
//
//   Widget _buildVideoPlayer() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 200,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             image: NetworkImage(widget.model.thumbnail!), fit: BoxFit.cover),
//       ),
//     );
//   }
// }
