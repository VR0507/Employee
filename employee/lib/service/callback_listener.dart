import 'package:get/get.dart';
abstract class CallBackListener extends GetxController{
  callBackFunction(String action,dynamic result);
  callBackFunctionError(String action,dynamic result);
}


