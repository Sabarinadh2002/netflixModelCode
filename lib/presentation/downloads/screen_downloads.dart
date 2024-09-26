import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_2/application/Downloads/downloads_bloc.dart';

import 'package:netflix_2/core/colors/constants.dart';
import 'package:netflix_2/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});

  final _WidgetList = [
    const _SmartDownloads(),
    Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarWidget(
            title: "Downloads",
          ),
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (ctx, index) => _WidgetList[index],
          separatorBuilder: (ctx, index) => SizedBox(
            height: 20,
          ),
          itemCount: _WidgetList.length,
        ));
  }
}

class Section2 extends StatelessWidget {
  Section2({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });

    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          "Inroducing downloads for you",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        kHeight,
        Text(
          "ashbieufewifdjk \n erqovier erq \n er vjqeb vdsvnsenre  \n oasdvnsd",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        kHeight,
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: size.width * .4,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        DownloadsImageWidgets(
                          imagelist:
                              '$imageAppendURL${state.downloads[0].posterPath}',
                          margin: EdgeInsets.only(left: 130, bottom: 50),
                          angle: 20,
                          size: Size(size.width * 0.4, size.width * 0.58),
                        ),
                        DownloadsImageWidgets(
                          imagelist:
                              '$imageAppendURL${state.downloads[1].posterPath}',
                          margin: EdgeInsets.only(right: 130, bottom: 50),
                          angle: -20,
                          size: Size(size.width * 0.4, size.width * 0.58),
                        ),
                        DownloadsImageWidgets(
                          imagelist:
                              '$imageAppendURL${state.downloads[2].posterPath}',
                          borderradiusvalur: 10,
                          margin: EdgeInsets.only(bottom: 10),
                          size: Size(size.width * 0.38, size.width * 0.60),
                        )
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: Colors.blueAccent,
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Set up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        kHeight,
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: Colors.white,
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "See what you can download",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kWidth,
        Icon(
          Icons.settings,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        kWidth,
        Text("Smart Downloads")
      ],
    );
  }
}

class DownloadsImageWidgets extends StatelessWidget {
  const DownloadsImageWidgets({
    super.key,
    required this.imagelist,
    this.angle = 0,
    required this.margin,
    required this.size,
    this.borderradiusvalur = 10,
  });

  final String imagelist;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double borderradiusvalur;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderradiusvalur),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              imagelist,
            ),
          ),
        ),
      ),
    );
  }
}
