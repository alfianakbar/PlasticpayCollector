import 'package:plasticpay/model/CollectorModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'Config.dart';
import 'SharedPrefService.dart';

Future<CollectorModel> findCollByID(int idCollector) async {
  String url = '${Config.url}//plastic/findCollectorId/$idCollector)';
  String token = await getSharedPrefString('token');
  final response = await http.get('$url', headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'Secret': Config.secret,
    'Authorization': token
  });
  print(response.body);
  return collectorModelFromJson(response.body);
}
