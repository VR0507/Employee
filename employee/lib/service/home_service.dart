import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/common/common_methods.dart';
import '../utils/common/helper.dart';
import 'callback_listener.dart';

class HomeService{
  http.Client client = http.Client();
  late String apiUrl;
  late String apiAction;
  late CallBackListener apiCallBackListener;
  late bool loaderShow;
  late Map<String, dynamic> apiFileMap;
  late Map<String, dynamic> apiBodyMap;
  late String reqType;

  Future<dynamic> apiRequestGet( CallBackListener callBackListener,String action,url ,{showLoader=true}) async {
    http.Response response;
    reqType="get";
    apiCallBackListener=callBackListener;
    apiAction=action;
    apiUrl=url;
    loaderShow=showLoader;

    var isConnected=await CommonMethods.checkInternetConnectivity();
    if(isConnected) {
      Map<String, String> headers = {};
      headers["Accept"] = "application/json";
      // headers["Authorization"] = "Bearer ${await appPreferences.getStringPreference(Constants.accessToken)}";
      // headers["client-id"] = apiList.cl;
      // headers["device-id"] = "12345";//(await PlatformDeviceId.getDeviceId)!;
      // print("Authorization=========== Bearer "+await appPreferences.getStringPreference(Constants.accessToken));

      try {
        // if(loaderShow) {
        //   Get.dialog( const Center(
        //     child: CircularProgressIndicator(
        //       color: Colors.black,
        //     ),
        //   ),
        //     barrierDismissible: false,
        //     useSafeArea: true,
        //   );
        // }
        response = await client.get(Uri.parse(apiUrl), headers: headers);
        // if(loaderShow){
        //   // willPop();
        //   loaderShow=false;
        //   // Future.delayed(const Duration(seconds: 1));
        //   Get.back();
        // }


        if (kDebugMode) {
          print("UrlCheck===" + url);
        }

        print("ResponseCheck===${response.body}");


          apiCallBackListener.callBackFunction(
              apiAction, json.decode(response.body));

      }on SocketException catch(cc){
        print("SocketError------> ${cc.message}");
      }
      catch(e){
        print('Error--->$e');
      }

    }else{
      showDailog();
    }
  }
  static HomeService newApiService(){
    final apiServices = HomeService();
    return apiServices;
  }

}
final apiServices= HomeService.newApiService();