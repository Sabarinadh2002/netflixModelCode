import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_2/application/search/search_bloc.dart';
import 'package:netflix_2/core/colors/constants.dart';
import 'package:netflix_2/domain/core/debounce/debounce.dart';
import 'package:netflix_2/presentation/search/search_result_page.dart';

import 'package:netflix_2/presentation/search/ssearch_idle.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});

  final _debounce = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoSearchTextField(
              backgroundColor: Colors.grey.withOpacity(0.4),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.grey,
              ),
              suffixIcon: const Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Colors.grey,
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
                _debounce.run(() {
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchMovie(movieQuery: value));
                });
              },
            ),
            kHeight,

            kHeight,

            Expanded(child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                log('Building SearchResult with ${state.searchResultList.length} results');
                if (state.searchResultList.isEmpty) {
                  return const SearchIdle();
                } else {
                  return const SearchResult();
                }
              },
            )),
            //Expanded(child: const SearchResult()),
          ],
        ),
      )),
    );
  }
}
