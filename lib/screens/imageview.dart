import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:textile/screens/widgets/circular_progress_indicator.dart';

class ImageViewer extends StatefulWidget {
  final String image;
  const ImageViewer({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            fadeInDuration: const Duration(seconds: 1),
            width: double.infinity,
            fit: BoxFit.fitWidth,
            imageUrl: 'https://www.textileutsav.com/machine/${widget.image}',
            progressIndicatorBuilder: (context, url, downloadProgress) => const AppProgressIndicator(color: Colors.red,),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
