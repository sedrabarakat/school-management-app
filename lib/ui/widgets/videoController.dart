import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatelessWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;
  final double controlsPlace;

  const ChewieListItem({
    required this.controlsPlace,
    required this.videoPlayerController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.35,
      width: double.infinity,
      child: Chewie(
        controller: ChewieController(
          controlsSafeAreaMinimum: EdgeInsets.only(top: controlsPlace),

          showControls: true,

          deviceOrientationsAfterFullScreen: [
            DeviceOrientation.portraitUp,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeLeft,
          ],
          deviceOrientationsOnEnterFullScreen: [
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeLeft,
          ],
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.blue,
            handleColor: Colors.blueAccent,
          ),

          videoPlayerController: videoPlayerController,
          aspectRatio: 16 / 9,
          // Prepare the video to be played and display the first frame
          autoInitialize: true,
          // Errors can occur for example when trying to play a video
          // from a non-existent URL
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
