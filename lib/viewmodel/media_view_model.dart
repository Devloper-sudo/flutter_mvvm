import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_architecture/model/apis/api_response.dart';
import 'package:flutter_mvvm_architecture/model/media.dart';
import 'package:flutter_mvvm_architecture/model/media_repository.dart';


class MediaViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.loading('Fetching artist data');

  Media _media;

  ApiResponse get response {
    return _apiResponse;
  }

  Media get media {
    return _media;
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> fetchMediaData(String value) async {
    try {
      List<Media> mediaList = await MediaRepository().fetchMediaList(value);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void setSelectedMedia(Media media) {
    _media = media;
    notifyListeners();
  }
}