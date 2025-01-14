// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'package:path_provider/path_provider.dart' as path_provider;
//
// class ModalImage {
//   final picker = ImagePicker();
//   final Function(String) onImageSelect;
//   final Function(String)? onFileSelect;
//   final bool isImageCroppable;
//
//   ModalImage({
//     required this.onImageSelect,
//     this.onFileSelect,
//     required this.isImageCroppable,
//   });
//
//   Future<void> callGallery() async {
//     try {
//       XFile? image = await picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         // Navigator.pop(ContextUtility.context!);  // Close modal after selection
//         await processImage(image.path);
//       }
//     } catch (e) {
//       log("Error picking image from gallery: $e");
//     }
//   }
//
//   Future<void> callCamera() async {
//     try {
//       XFile? image = await picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         // Navigator.pop(ContextUtility.context!); // Close modal after selection
//         await processImage(image.path);
//       }
//     } catch (e) {
//       log("Error picking image from camera: $e");
//     }
//   }
//
//
//
//   Future<void> processImage(String imagePath) async {
//     try {
//       final dir = await path_provider.getTemporaryDirectory();
//       final targetPath = '${dir.absolute.path}/temp.jpg';
//
//       final result = await FlutterImageCompress.compressAndGetFile(
//         imagePath,
//         targetPath,
//         minHeight: 720,
//         minWidth: 720,
//         quality: 85,
//       );
//
//       if (result != null) {
//         onImageSelect(imagePath);
//       }
//     } catch (e) {
//       log("Error during image processing: $e");
//     }
//   }
//
//   void mainBottomSheet(BuildContext context, {String? type}) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text("Gallery"),
//                 onTap: () async {
//                   await callGallery();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.camera),
//                 title: const Text("Camera"),
//                 onTap: () async {
//                   await callCamera();
//                 },
//               ),
//
//               ListTile(
//                 leading: const Icon(Icons.cancel),
//                 title: const Text("Cancel"),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
