import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class CourseCorousel extends StatefulWidget {
  final double extent;
  final double height;
  const CourseCorousel({super.key, required this.extent,required this.height});

  @override
  State<CourseCorousel> createState() => _CourseCorouselState();
}

class _CourseCorouselState extends State<CourseCorousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: InfiniteCarousel.builder(
          itemCount: 10,
          itemExtent: widget.extent,
          center: true,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
