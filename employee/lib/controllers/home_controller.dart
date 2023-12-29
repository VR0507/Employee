import 'dart:io';

import 'package:employee/database/database_model.dart';
import 'package:employee/main.dart';
import 'package:employee/service/api_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/home_model/employee_model.dart';
import '../service/callback_listener.dart';
import '../service/home_service.dart';
import '../utils/common/helper.dart';

class HomeController extends GetxController implements CallBackListener {
  final RxList<Employee> employees = <Employee>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxBool edit = false.obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final RxString image = ''.obs;

  @override
  void onInit() {
    getAllEmployeeFromApi();
    super.onInit();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    edit.value = false;
    if (employees.isNotEmpty) {
      final List<String> nameParts = employees[currentIndex.value].name?.split(" ") ?? [];
      firstNameController.text = nameParts.first ?? '';
      lastNameController.text = nameParts.length > 1 ? nameParts.sublist(1).join(" ") : '';
      emailController.text = employees[currentIndex.value].email ?? '';
      image.value = employees[currentIndex.value].image ?? '';
    }
  }

  Future<void> getAllEmployeeFromApi() async {
    if (database?.employeeDao.findAllEmployee().isBlank == true) {
      await apiServices.apiRequestGet(this, "Get All User", '${ApiList().user}?page=1');
    } else {
      await getEmployeeFromDatabase();
    }
  }

  Future<void> getEmployeeFromDatabase() async {
    employees.value = await database?.employeeDao.findAllEmployee() ?? [];
    if (employees.isNotEmpty) {
      firstNameController.text = employees[currentIndex.value].name?.split(" ").first ?? '';
      lastNameController.text =
          employees[currentIndex.value].name?.substring(employees[currentIndex.value].name?.split(" ").first.length ?? 0) ?? '';
      emailController.text = employees[currentIndex.value].email ?? '';
      image.value = employees[currentIndex.value].image ?? '';
      print(employees[currentIndex.value].image);
      print(image.value);
    }
  }

  Future<void> deleteUser() async {
    await database?.employeeDao.deleteEmployee(employees[currentIndex.value].id ?? 0);
    await getEmployeeFromDatabase();
    edit.value = false;
  }

  Future<void> updateData() async {
    final String? imagePath = await saveImageToLocalCache("${firstNameController.text}${lastNameController.text}", image.value);
    print(imagePath);
    await database?.employeeDao.updateEmployee(Employee(
        id: employees[currentIndex.value].id,
        email: emailController.text,
        image: imagePath,
        name: "${firstNameController.text} ${lastNameController.text}"));
    await getEmployeeFromDatabase();
    edit.value = false;
  }

  Future<void> pickImage() async {
    image.value = await processImage(ImageSource.gallery) ?? '';
  }

  @override
  void callBackFunction(String action, result) async {
    print(result);
    if (action == "Get All User") {
      result["data"]?.forEach((element) async {
        await database?.employeeDao.insertEmployee(Employee(name: element["name"], email: '', image: ''));
      });
      await getEmployeeFromDatabase();
    }
  }

  @override
  void callBackFunctionError(String action, result) {
    print("er=>$result");
  }
}
