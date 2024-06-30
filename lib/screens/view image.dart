import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullScreenImageView extends StatefulWidget {
  final List<QueryDocumentSnapshot> images;
  final int initialIndex;

  const FullScreenImageView({required this.images, required this.initialIndex});

  @override
  _FullScreenImageViewState createState() => _FullScreenImageViewState();
}

class _FullScreenImageViewState extends State<FullScreenImageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          var imageUrl = widget.images[index]['url'];
          var caption = widget.images[index]['caption'];

          return Column(

            children: [
              SafeArea(child: SizedBox()),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffc5607e),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Icon(Icons.error));
                    },
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: 16.0.w,left: 16.w,top: 8.h,bottom: 8.h),
                child: Text(
                  caption,
                  style: TextStyle(
                    color: Color(0xff161616),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
