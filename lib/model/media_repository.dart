import 'package:flutter_mvvm_architecture_sample/model/media.dart';
import 'package:flutter_mvvm_architecture_sample/model/services/base_service.dart';
import 'package:flutter_mvvm_architecture_sample/model/services/media_service.dart';

class MediaRepository {
  BaseService _mediaService = MediaService();

  Future<List<Media>> fetchMediaList(String value) async {
    dynamic response = await _mediaService.getResponse(value);
    final jsonData = response['results'] as List;
    List<Media> mediaList =
        jsonData.map((jsonTag) => Media.fromJson(jsonTag)).toList();
    return mediaList;
  }
}
