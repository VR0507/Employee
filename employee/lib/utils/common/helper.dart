import 'dart:io';
import 'dart:typed_data';

import 'package:employee/utils/resources/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import '../resources/images.dart';

showDailog(){
  Get.defaultDialog(
      title: '',
      content:Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(AppImages.noInternet, height: 44,width: 44,),
          ),
          Text(AppStrings.noInternet,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
          Text(AppStrings.checkInternet,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
        ],
      ),
      actions: <Widget>[ TextButton(onPressed: () async {
        await Future.delayed(Duration(seconds: 1));
        Get.back();
      },
        child: Text(AppStrings.ok),
      )]
  );
}
Future<String?> processImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    File selectedImage = File(pickedFile.path);
    File img=await compressImage(selectedImage);
    return img.path;
  }
  return null;
}

Future<File> compressImage(File image) async {
  img.Image originalImage = img.decodeImage(await image.readAsBytes())!;

  img.Image compressedImage = img.copyResize(originalImage, width: 80);

  File compressedFile = File('${image.path}_compressed.jpg')
    ..writeAsBytesSync(img.encodeJpg(compressedImage));

  return compressedFile;
}
Future<String?> saveImageToLocalCache(String imageName, String filePath) async {
  try {
    // Get the temporary directory using path_provider
    File file = File(filePath);
    List<int> bytes = await file.readAsBytes();
    ByteData byteData = ByteData.sublistView(Uint8List.fromList(bytes));
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // Create a File instance and write the image data to it
    File imageFile = File('$tempPath/$imageName');
    await imageFile.writeAsBytes(byteData.buffer.asUint8List());

    print('Image saved successfully at: ${imageFile.path}');
    return imageFile.path;
  } catch (e) {
    print('Error saving image: $e');
  }
  return null;
}
