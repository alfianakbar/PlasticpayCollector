import 'package:plasticpaycoll/model/ConversionModel.dart';
import 'Config.dart';
import 'package:http/http.dart' as http;
import 'SharedPrefService.dart';
import 'dart:async';
import 'dart:io';

Future<ConversionModel> getConversion() async {
  String url = '${Config.url}/getPlasticConversion';
  String token = await getSharedPrefString('token');
  final response = await http.get(
    '$url',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Secret': Config.secret,
      'Authorization': token
    },
  );
  return conversionModelFromJson(response.body);
}
