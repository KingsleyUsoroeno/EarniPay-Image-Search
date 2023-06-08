import 'package:earnipay_image_search/di/injection.dart';
import 'package:earnipay_image_search/ui/photo-search/cubit/photo_search_cubit.dart';
import 'package:earnipay_image_search/ui/photo-search/photo_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/photo_item.dart';

class PhotoSearchScreen extends StatefulWidget {
  const PhotoSearchScreen({Key? key}) : super(key: key);

  @override
  State<PhotoSearchScreen> createState() => _PhotoSearchScreenState();
}

class _PhotoSearchScreenState extends State<PhotoSearchScreen> {
  final cubit = getIt<PhotoSearchCubit>();
  bool _isLoadingMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: BlocBuilder<PhotoSearchCubit, PhotoSearchState>(
          bloc: cubit,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi,There",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 26),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          key: const Key('search-text-field'),
                          decoration: const InputDecoration(
                            hintText: "Search",
                            prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 6), child: Icon(Icons.search)),
                            border: InputBorder.none,
                          ),
                          onSubmitted: cubit.performImageSearch,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildBody(state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(PhotoSearchState state) {
    return Expanded(
      child: switch (state) {
        ImageSearchLoadingState() => const Center(child: CircularProgressIndicator()),
        ImageSearchInitialState() => Center(
            child: Text(
              'Go ahead and search for an amazing image you would love to see',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ImageSearchLoadedState() => NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  _isLoadingMore == false) {
                setState(() => _isLoadingMore = true);
                cubit
                    .loadMoreImages(state.imageResults)
                    .then((_) => setState(() => _isLoadingMore = false));
              }
              return true;
            },
            child: CustomScrollView(
              key: const Key('image-search-result-grid-view'),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 20.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 4 / 5,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.imageResults.length,
                      (_, int index) {
                        final photo = state.imageResults[index];
                        return PhotoItem(
                          imageUrl: photo.regular,
                          title: photo.title,
                          index: index,
                          onTapped: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PhotoDetailScreen(photoResult: photo, index: index),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                if (_isLoadingMore)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 24, 8, 13),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            ),
          ),
        ImageSearchErrorState() => Center(
            child: Column(
              key: const Key('search-result-grid-view'),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Oops, Something went wrong :)',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (state.onTryAgain != null)
                  TextButton(
                    onPressed: state.onTryAgain,
                    child: Text('Try again', style: Theme.of(context).textTheme.bodyMedium),
                  )
              ],
            ),
          ),
      },
    );
  }
}
