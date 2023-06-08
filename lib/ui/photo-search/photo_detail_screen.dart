import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final String imageUrl, title;
  final int index;

  const PhotoDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
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
            tag: "$imageUrl$index",
            transitionOnUserGestures: true,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge,),
          )
        ],
      ),
    );
  }
}
