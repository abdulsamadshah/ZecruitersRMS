import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../common_widget/common_widget.dart';

class ViewFullImage extends StatelessWidget {
  ViewFullImage({super.key, required this.title, required this.pimgurl});
  String title = "";
  String pimgurl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: reausabletext(title,
            fontfamily: FontFamily.interMedium,
            fontsize: 15,
            color: Colors.white),
      ),
      body: Center(
        child: CachedNetworkImage(
          width: MediaQuery.sizeOf(context).width,
          imageUrl:
              pimgurl,
          fit: BoxFit.cover,
          placeholder: (context, string) => const Center(
            child: CircularProgressIndicator(),
          ),

        ),

      ),
    );
  }
}
