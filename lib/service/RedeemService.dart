import 'package:plasticpaycoll/model/RedeemModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'Config.dart';
import 'SharedPrefService.dart';

Future<RedeemModel> redeem(int poin) async {
  String url = '${Config.url}/redeem/store';
  String body = '{ "total_point": $poin }';
  String token = await getSharedPrefString('token');
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': token,
        'Secret': Config.secret,
      },
      body: body);
//  print(response.body);
  return redeemModelFromJson(response.body);
}
