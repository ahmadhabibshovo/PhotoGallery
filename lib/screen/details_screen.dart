import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

import '../data/models/photo_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.photo,
    required this.photosSuggestions,
  });

  final bool loaded = false;
  final List<PhotoModel> photosSuggestions;

  final PhotoModel photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff2CAB00),
          title: Text(photo.type, style: const TextStyle(color: Colors.white)),
          leading: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white30),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 35,
              ),
            )
          ],
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: CachedNetworkImage(
                      imageUrl: photo.imageUrl,
                      alignment: Alignment.bottomLeft,
                      imageBuilder: (context, imageProvider) => Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        photo.title.capitalizeEach(),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(photo.description.capitalizeEach()),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2CAB00),
                          ),
                          child: const Text(
                            "See More",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Suggestion',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff2CAB00)),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .9,
                          crossAxisCount: 2,
                          crossAxisSpacing: 30,
                          // Two columns in the grid
                        ),
                        itemCount: photosSuggestions.length,
                        itemBuilder: (context, index) {
                          final photo = photosSuggestions[index];
                          return CachedNetworkImage(
                            imageUrl: photo.previewUrl,
                            alignment: Alignment.bottomLeft,
                            imageBuilder: (context, imageProvider) => Container(
                              alignment: Alignment.bottomLeft,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(2.0,
                                        2.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  photo.type,
                                  style: const TextStyle(
                                      backgroundColor: Colors.black38,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: CachedNetworkImage(
                          imageUrl: photo.imageUrl,
                          alignment: Alignment.bottomLeft,
                          imageBuilder: (context, imageProvider) => Container(
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0,
                                      2.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 18, 18, 0),
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Mood With Nuture",
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(photo.description.capitalizeEach()),
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2CAB00),
                                ),
                                child: const Text(
                                  "See More",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              )),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Sueggstion',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xff2CAB00)),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: .9,
                                crossAxisCount: 2,
                                crossAxisSpacing: 30,
                                // Two columns in the grid
                              ),
                              itemCount: photosSuggestions.length,
                              itemBuilder: (context, index) {
                                final photo = photosSuggestions[index];
                                return CachedNetworkImage(
                                  imageUrl: photo.previewUrl,
                                  alignment: Alignment.bottomLeft,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(2.0,
                                              2.0), // shadow direction: bottom right
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        photo.type,
                                        style: const TextStyle(
                                            backgroundColor: Colors.black38,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
