import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/core/utils/popups/snackbars.dart';
import 'package:tiktok_tdd/src/reels/presentation/pages/upload_video.dart';

class SelectVideoScreen extends StatefulWidget {
  const SelectVideoScreen({super.key});

  @override
  State<SelectVideoScreen> createState() => _SelectVideoScreenState();
}

class _SelectVideoScreenState extends State<SelectVideoScreen> {
  pickVideo(ImageSource source) async {
    final video = await ImagePicker()
        .pickVideo(source: source, maxDuration: const Duration(minutes: 1));
    if (video != null) {
      // ignore: use_build_context_synchronously
      TNavigators.navigatePush(context,
          UploadVideoScreen(video: File(video.path), videoPath: video.path));
    } else {
      // ignore: use_build_context_synchronously
      TSnackBar.showErrorSnackBar(
          context: context, message: "Please Select Video");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                pickVideo(ImageSource.gallery);
              },
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: TColors.lightBlue,
                ),
                child: const Center(
                  child: Text(
                    "Import from Gallery",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                pickVideo(ImageSource.camera);
              },
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: TColors.lightRed,
                ),
                child: const Center(
                  child: Text(
                    "Import from Camera",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
