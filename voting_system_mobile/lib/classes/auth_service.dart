import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:voting_system_mobile/utils/color_util.dart';
import 'package:voting_system_mobile/utils/constants_util.dart';
import 'package:dio/dio.dart';

class AuthService{

  Dio dio = Dio();

  // Future login(String email, String password) async{
  //   try{
  //     response = await http.post(
  //         Uri.http(kBaseUrl + 'signin', ""),
  //         headers: <String, String>{
  //           'Context-Type': 'applications/json;charSet=UTF-8'
  //         },
  //         body: <String, String>{
  //           'email': email,
  //           'password': password
  //         },
  //     );
  //   } catch (e){
  //     Fluttertoast.showToast(
  //         msg: response.statusCode.toString(),
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.white,
  //       textColor: tealColors,
  //       fontSize: 16.0
  //     );
  //   }
  // }

  Future register(String email, String password, String firstName, String lastName, String phoneNumber, String userName) async{
    try{
        return await dio.post(
        kBaseUrl + 'register',
        data: <String, String>{
          'firstname': firstName,
          'lastname': lastName,
          'phone': phoneNumber,
          'username': userName,
          'email': email,
          'password': password,
        },
      );
    } on DioError catch (e){
      Fluttertoast.showToast(
          msg: e.response == null ? 'response is null' : e.response.data,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: tealColors,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}