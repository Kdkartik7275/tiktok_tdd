import 'package:image_picker/image_picker.dart';
import 'package:video_compress_ds/video_compress_ds.dart';
import 'package:timeago/timeago.dart' as timeago;

class TFunctions {
  Future<XFile?> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      // File? selectedImage = File(pickedImage.path);
      return pickedImage;
    }
    return null;
  }

  Future<XFile?> getVideo(ImageSource source) async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(
        source: source, maxDuration: const Duration(minutes: 10));

    if (pickedVideo != null) {
      // File? selectedImage = File(pickedImage.path);
      return pickedVideo;
    }
    return null;
  }

  compressVideo(String path) async {
    final compressVideo = await VideoCompress.compressVideo(path,
        quality: VideoQuality.MediumQuality);
    return compressVideo!.path;
  }

  String extractCaption(String input) {
    RegExp hashtagRegex = RegExp(r'#\w+');

    // Removing hashtags from the input string
    String caption = input.replaceAll(hashtagRegex, '').trim();

    return caption;
  }

  String extractHashtags(String input) {
    RegExp hashtagRegex = RegExp(r'#\w+');

    Iterable<Match> matches = hashtagRegex.allMatches(input);
    List<String> hashtags = matches.map((match) => match.group(0)!).toList();
    String hashtagsString = hashtags.join(' ');
    return hashtagsString;
  }

  String getTimeAgo(DateTime time) {
    final datetime = time.subtract(const Duration(minutes: 1));
    return timeago.format(datetime);
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].codeUnits[0] > user2[0].codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
}
