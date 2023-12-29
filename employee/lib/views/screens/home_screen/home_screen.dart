import 'dart:io';

import 'package:employee/controllers/home_controller.dart';
import 'package:employee/utils/resources/color.dart';
import 'package:employee/views/widget/custom_button.dart';
import 'package:employee/views/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              controller.getEmployeeFromDatabase();
            },
            icon: const Icon(
              Icons.replay,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Obx(() {
        return Container(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int index = 0; index < controller.employees.length; index++)
                      buildEmployeeCard(index),
                  ],
                ),
              ),
              if (controller.employees.isNotEmpty) buildEmployeeInfoCard(),
            ],
          ),
        );
      }),
    );
  }

  Widget buildEmployeeCard(int index) {
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: controller.currentIndex.value == index
              ? Colors.deepOrangeAccent
              : AppColors.veryLightGreyColor,
          border: Border(
            right: BorderSide(color: AppColors.lightGrey),
          ),
        ),
        alignment: Alignment.center,
        child: Text(controller.employees[index].name ?? ''),
      ),
    );
  }

  Widget buildEmployeeInfoCard() {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileImage(),
                const Spacer(),
                buildEditAndDeleteButtons(),
              ],
            ),
            buildEditableFields(),
            if (controller.edit.value) buildUpdateButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildProfileImage() {
    return GestureDetector(
      onTap: () => controller.edit.value ? controller.pickImage() : null,
      child: CircleAvatar(
        radius: 40,
        backgroundImage: controller.image.value.isNotEmpty
            ? FileImage(File(controller.image.value)) as ImageProvider
            : const NetworkImage(
            "https://simplyilm.com/wp-content/uploads/2017/08/temporary-profile-placeholder-1.jpg"),
      ),
    );
  }

  Widget buildEditAndDeleteButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => controller.edit.value = true,
          icon: const Icon(
            Icons.edit_outlined,
            color: AppColors.greenColor,
          ),
          tooltip: "EDIT",
        ),
        IconButton(
          onPressed: () => controller.deleteUser(),
          icon: const Icon(
            Icons.delete,
            color: AppColors.redColor,
          ),
          tooltip: "DELETE",
        ),
      ],
    );
  }

  Widget buildEditableFields() {
    return IgnorePointer(
      ignoring: !controller.edit.value,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("First Name : "),
              Expanded(
                child: CustomTextField(
                  controller: controller.firstNameController,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Last Name : "),
              Expanded(
                child: CustomTextField(
                  controller: controller.lastNameController,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Email : "),
              Expanded(
                child: CustomTextField(
                  controller: controller.emailController,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildUpdateButtons() {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: "Cancel",
                onPressEvent: () => controller.edit.value = false,
                btnColor: AppColors.whiteColor,
                textColor: AppColors.greyDarkLightColor,
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: CustomButton(
                text: "Update",
                onPressEvent: () => controller.updateData(),
                btnColor: AppColors.redColor,
                textColor: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
