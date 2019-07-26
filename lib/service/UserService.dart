import 'package:plasticpay/model/LoginModel.dart';
import 'package:plasticpay/model/ProfileModel.dart';
import 'package:plasticpay/model/PinModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'Config.dart';
import 'SharedPrefService.dart';

Future<bool> isLogin() async {
  String token = await getSharedPrefString('token');
  return (token != 'kosong');
}

Future login(String email, String password) async {
  String url = '${Config.url}/login';
  String body = '{"email":"$email","password": "$password"}';
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Secret': Config.secret,
      },
      body: body);
//  print(url);
//  print(response.body);
  LoginModel loginModel = loginModelFromJson(response.body);
  if (loginModel.content == null) {
    setSharedPrefString('token', 'kosong');
  } else {
    setSharedPrefString('token', 'Bearer ${loginModel.content.token}');
  }
}

Future<ProfileModel> getProfile() async {
  String url = '${Config.url}/profile';
  String token = await getSharedPrefString('token');
  final response = await http.get('${url}',
      headers: {'Secret': Config.secret, 'Authorization': token});
  print(token);
  print(response.body);
  try {
    return profileModelFromJson(response.body);
  } catch (e) {
    return null;
  }
}

Future register(User user) async {
  String url = '${Config.url}/register';
  String body = user.toJson().toString();
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Secret': Config.secret,
      },
      body: body);
//  print(response.body);
  try {
    LoginModel loginModel = loginModelFromJson(response.body);
    setSharedPrefString('token', 'Bearer ${loginModel.content.token}');
  } catch (e) {
    setSharedPrefString('token', 'kosong');
  }
}

Future<bool> registerString(String user) async {
  String url = '${Config.url}/registration';
  String body = user;
  print(body);
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Secret': Config.secret,
      },
      body: body);
//  print(response.body);
  LoginModel loginModel = loginModelFromJson(response.body);
  if ((loginModel == null) || (loginModel.status == 'error')) {
    setSharedPrefString('token', 'kosong');
    return false;
  } else {
    setSharedPrefString('token', 'Bearer ${loginModel.content.token}');
    return true;
  }
}

Future<ProfileModel> editProfile(
    String user, String email, String password) async {
  String url = '${Config.url}/profile';
  String token = await getSharedPrefString('token');
  String body = user;
  final response = await http.put('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Secret': Config.secret,
        'Authorization': token
      },
      body: body);
//  print(response.body);
  try {
    ProfileModel profileModel = profileModelFromJson(response.body);
    await login(email, password);
    return profileModel;
  }catch(e){
    return null;
  }
}

Future logout() async {
  String url = '${Config.url}/logout';
  await setSharedPrefString('token', 'kosong');
  final response = await http.post(url);
}

Future<bool> checkPin(int pin) async {
  String url = '${Config.url}/checkPin';
  String body = '{"pin":$pin}';
  String token = await getSharedPrefString('token');
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Secret': Config.secret,
        'Authorization': token
      },
      body: body);
//  print(response.body);
  try {
    return pinModelFromJson(response.body).status == 'success';
  }catch(e){
    return null;
  }
}
