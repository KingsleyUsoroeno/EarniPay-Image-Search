import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoItem extends StatelessWidget {
  final VoidCallback onTapped;
  final String imageUrl, title;
  final int index;

  const PhotoItem({
    Key? key,
    required this.onTapped,
    required this.index,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.0), blurRadius: 0.1)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: "$imageUrl$index",
            transitionOnUserGestures: true,
            child: Material(
              child: InkWell(
                onTap: onTapped,
                child: Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
