import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart ';
import 'package:netflix_2/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_2/core/colors/constants.dart';
import 'package:netflix_2/domain/Downloads/models/downloads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/src/widgets/framework.dart';

class VideoListIteminheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListIteminheritedWidget(
      {Key? key, required this.widget, required this.movieData})
      : super(key: key,child: widget);

  @override
  bool updateShouldNotify(covariant VideoListIteminheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListIteminheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListIteminheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListIteminheritedWidget.of(context)?.movieData.posterPath;

    final videoURL = dummyvideoUrl[index % dummyvideoUrl.length];
    return Stack(children: [
      FastLaughVideoPlayer(
        videoURL: videoURL,
        onStateChange: (bool) {},
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //left side
              CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.5),
                radius: 30,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.volume_off,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              //right side
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage('$imageAppendURL$posterPath')),
                  ),
                  ValueListenableBuilder(
                    valueListenable: likedVideoNotifier,
                    builder:
                        (BuildContext c, Set<int> newLikedLisId, Widget? _) {
                      final _index = index;
                      if (newLikedLisId.contains(_index)) {
                        return  GestureDetector  (
                          onTap: ()  {
                            likedVideoNotifier.value.remove(_index);
                            likedVideoNotifier.notifyListeners();
                            // BlocProvider.of<FastLaughBloc>(context).add(UnLikedVideo(id: _index)),
                          },
                          child: const VideoActionWidget(
                            icon: Icons.favorite_outlined,
                            title: "Liked",
                          ),
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          //BlocProvider.of<FastLaughBloc>(context).add(FavarateVideo(id: _index)),
                          likedVideoNotifier.value.add(_index);
                          likedVideoNotifier.notifyListeners();
                        },
                        child: VideoActionWidget(
                            icon: Icons.emoji_emotions, title: "LOL"),
                      );
                    },
                  ),
                  VideoActionWidget(icon: Icons.add, title: "Add"),
                  GestureDetector(
                      onTap: () {
                        final movieName =
                            VideoListIteminheritedWidget.of(context)
                                ?.movieData
                                .posterPath;
                        if (movieName != null) {
                          Share.share(movieName);
                        }
                      },
                      child: const
                          VideoActionWidget(icon: Icons.share, title: "Share")),
                  VideoActionWidget (icon: Icons.play_arrow, title: "Play"),
                ],
              )
            ],
          ),
        ),
      )
    ]);
  }
}

class VideoActionWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const VideoActionWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoURL;
  final void Function(bool isPlaying) onStateChange;
  const FastLaughVideoPlayer(
      {super.key, required this.videoURL, required this.onStateChange});

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoURL));
    _videoPlayerController.initialize().then((value) {
      setState(() {});
      _videoPlayerController.play();
      widget.onStateChange(true);
    });

    _videoPlayerController.addListener((){
      if(_videoPlayerController.value.hasError){
        print("Video Error: ${_videoPlayerController.value.errorDescription}");
        widget.onStateChange(false);
      }
      final isPlaying = _videoPlayerController.value.isPlaying;
      widget.onStateChange(isPlaying);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
            :const Center ( 
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
