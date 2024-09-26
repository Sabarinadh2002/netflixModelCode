import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_2/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_2/presentation/fast_laugh/widgets/video_list_item.dart';

class ScreenFastLaugh extends StatefulWidget {
  const ScreenFastLaugh({super.key});

   @override
  _ScreenFastlaughState createState()=> _ScreenFastlaughState();
}

 class _ScreenFastlaughState extends State<ScreenFastLaugh>{
  @override
  void initState() {
    super.initState();
    // Trigger the Initialize event
    BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
  }
  
  
  
 

  @override
  Widget build(BuildContext context) {
    // edits cheythu
    //WidgetsBinding.instance.addPersistentFrameCallback((_) {
    //BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    //});
    return Scaffold(
      body: SafeArea(
        child: BlocListener<FastLaughBloc, FastLaughState>(
          //builder: (context, state) {
          listener: (context, state) {},
          child: BlocBuilder<FastLaughBloc, FastLaughState>(
            builder: (context, state) {
              if (state.isloading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              } else if (state.isError) {
                return Center(
                  child: Text("Error while getting data"),
                );
              } else if (state.videoList.isEmpty) {
                return Center(
                  child: Text("Video list is empty"),
                );
              } else {
                return PageView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(state.videoList.length, (index) {
                    return VideoListIteminheritedWidget(
                      widget: VideoListItem(
                          key: Key(index.toString()), index: index),
                      movieData: state.videoList[index],
                    );
                  }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  
 }