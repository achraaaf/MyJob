
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotosWidget extends StatelessWidget {
  const PhotosWidget({
    super.key,
    required this.controller,
  });

  final controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        separatorBuilder: (context, __) => SizedBox(width: 10),
        itemCount: controller.photos.length,
        scrollDirection: Axis.horizontal,
        //reverse: true,
        itemBuilder: (context, index) {
          final photoUrl =
              controller.photos.reversed.toList()[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoView(
                    imageProvider: NetworkImage(photoUrl),
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 200,
                    child: Image.network(
                      photoUrl,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 5,
                  child: GestureDetector(
                    onTap: () async {
                      controller.photos.remove(photoUrl);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
