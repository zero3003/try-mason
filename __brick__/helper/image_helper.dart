import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'location_helper.dart';
import 'stamp_image.dart';

import 'logger.dart';

class ImageHelper {
  Future<File?> selectImage(Size size) async {
    File? img;
    await Get.dialog(
      AlertDialog(
        title: const Text('Pilih salah satu'),
        content: SizedBox(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  img = await imagePick(isCamera: true);
                  Get.back();
                },
                icon: const Icon(
                  Icons.photo_camera,
                  color: Colors.black,
                ),
                label: Row(
                  children: const [
                    Text(
                      'Kamera',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  img = await imagePick(isCamera: false);
                  Get.back();
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                label: Row(
                  children: const [
                    Text(
                      'Galeri',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return img;
  }

  Future imagePick({bool isCamera = false}) async {
    File _image;
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await picker.getImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      // maxHeight: 1200,
      // maxWidth: 1200,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image;
    } else {
      return null;
    }
  }

  Future<File?> selectImageWithWatermark(Size size) async {
    File? img;
    await Get.dialog(
      AlertDialog(
        title: const Text('Pilih salah satu'),
        content: SizedBox(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  img = await imagePick(isCamera: true);
                  if(img != null) img = await imageWatermarking(img!, size);
                  Get.back();
                },
                icon: const Icon(
                  Icons.photo_camera,
                  color: Colors.black,
                ),
                label: Row(
                  children: const [
                    Text(
                      'Kamera',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  img = await imagePick(isCamera: false);
                  if(img != null) img = await imageWatermarking(img!, size);
                  Get.back();
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                label: Row(
                  children: const [
                    Text(
                      'Galeri',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return img;
  }

  Future<File?> imageWatermarking(File file, Size size) async {
    File? foto;
    try {
      var loc = await getCurrentLocation();
      List<geo.Placemark> placemark = await getPlacemark(loc);
      await Get.to(() => StampWidget(
            image: file,
            loc: loc,
            placemarks: placemark,
            size: size,
            onSuccess: (value) {
              foto = value;
            },
          ));
    } catch (e) {
      EasyLoading.showError("$e");
    }
    return foto;
  }

  Future<bool> isHorizontalImage(File image) async {
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    return decodedImage.width > decodedImage.height;
  }
}
