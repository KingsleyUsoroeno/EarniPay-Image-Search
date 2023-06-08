import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_image_search/domain/models/photo_search_result.dart';
import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final PhotoSearchResult photoResult;
  final int index;

  const PhotoDetailScreen({
    Key? key,
    required this.photoResult,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details", style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          iconSize: 20,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: "${photoResult.regular}$index",
            transitionOnUserGestures: true,
            child: SizedBox(
              height: 400,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: photoResult.regular,
                progressIndicatorBuilder: (_, __, ___) => const CircularProgressIndicator(),
                errorWidget: (_, __, ___) => Container(color: Colors.redAccent),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium,
                  text: "This photo was taken by the author ",
                  children: [
                    TextSpan(
                        text: photoResult.authorName,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold))
                  ]),
            ),
          ),
          if (photoResult.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: Text(
                photoResult.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
