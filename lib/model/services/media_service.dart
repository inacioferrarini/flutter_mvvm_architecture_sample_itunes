import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_mvvm_architecture_sample/model/apis/app_exception.dart';
import 'package:flutter_mvvm_architecture_sample/model/services/base_service.dart';

class MediaService extends BaseService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(mediaBaseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while exchangedata with server' +
                'with status code: ${response.statusCode}');
    }
  }
}
