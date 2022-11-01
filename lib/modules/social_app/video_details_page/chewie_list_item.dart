import 'package:chewie/chewie.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const ChewieListItem({
    required this.videoPlayerController,
    Key? key,
  }) : super(key: key);

  @override
  ChewieListItemState createState() => ChewieListItemState();
}

class ChewieListItemState extends State<ChewieListItem> {
  ChewieController? _chewieController;
  late VideoPlayerController _videoPlayerController1;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController!.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = widget.videoPlayerController;

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
        color: Colors.black26,
      ),
      autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: _chewieController != null &&
          _chewieController!.videoPlayerController.value.isInitialized,
      builder: (BuildContext context) => AspectRatio(
        // aspectRatio: 16 / 9,
          aspectRatio:_chewieController!.videoPlayerController.value.aspectRatio,
        child: Chewie(
            controller: _chewieController!,
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
    );
  }
}
