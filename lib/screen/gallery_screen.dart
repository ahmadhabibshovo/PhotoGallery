import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

import '../data/models/photo_model.dart';
import '../data/photo_info.dart';

import 'details_screen.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key});

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  bool loaded = false;
  List<PhotoModel> photos = [];

  getPhoto() async {
    for (var photoInfo in photosInfo) {
      final response = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=26317384-406957ac90fb565a59528af15&q=${photoInfo[0]}&image_type=photo&per_page=3'));
      final loadedPhotos = jsonDecode(response.body);
      final loadedPhoto = loadedPhotos['hits'][2];
      photos.add(PhotoModel(
        title: photoInfo[2],
          type: photoInfo[0],
          previewUrl: loadedPhoto['webformatURL'],
          imageUrl: loadedPhoto['largeImageURL'],
          description: photoInfo[1], ));
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    getPhoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff2CAB00),
        title: const Text('Photo Gallery', style: TextStyle(color: Colors.white)),
        leading: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), color: Colors.white30),
          child: IconButton(
            onPressed: () {},
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
      body: !loaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : OrientationBuilder(builder: (context,orientation){
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .9,
                  crossAxisCount: orientation == Orientation.landscape?4:2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30 // Two columns in the grid
              ),
              itemCount: photosInfo.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            final suggestion = [...photos];
                            suggestion.shuffle();
                            return DetailsScreen(
                              photo: photo,
                              photosSuggestions: suggestion.sublist(8),
                            );
                          }
                      ),
                    );
                  },
                  child:CachedNetworkImage(
                    imageUrl: photo.previewUrl,

                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover), borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
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
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ));

              },
            );
      })
    );
  }
}
