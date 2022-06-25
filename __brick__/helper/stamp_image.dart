import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import '../common/color.dart';
import '../common/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_image_full.dart';
import '../widgets/custom_text_form_field.dart';
import 'extensions.dart';

import '../widgets/custom_text.dart';

class StampImage {
  ///Create watermark to an existing image file [image] and custom Widget as the watermark item.
  ///You can customize the position using alignment
}

class StampWidget extends StatefulWidget {
  final File? image;
  final Function(File)? onSuccess;
  final LocationData loc;
  final List<geo.Placemark> placemarks;
  final Size size;
  final bool isHorizontalImage;

  const StampWidget({
    Key? key,
    required this.loc,
    required this.image,
    this.onSuccess,
    required this.placemarks,
    required this.size,
    this.isHorizontalImage = false,
  }) : super(key: key);

  @override
  _StampWidgetState createState() => _StampWidgetState();
}

class _StampWidgetState extends State<StampWidget> {
  ///Global frame key
  final frameKey = GlobalKey();

  ///Set widget from RepaintBoundary into uint8List
  ///and convert into File

  ///Converting Widget to PNG
  Future<Uint8List?> getUint8List(GlobalKey widgetKey) async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 5.0);
    ByteData? byteData = await (image.toByteData(format: ImageByteFormat.png));
    return byteData?.buffer.asUint8List();
  }

  Uint8List? _imageFileGoogleMap;
  Set<Marker> markers = HashSet<Marker>();
  bool isShowMap = true;
  GoogleMapController? _mapController;
  final Completer<GoogleMapController> _controller = Completer();

  Widget buildGmap(LocationData loc, Size size) {
    markers.add(Marker(
        markerId: const MarkerId('current'), position: LatLng(loc.latitude ?? 0, loc.longitude ?? 0)));
    return GoogleMap(
      markers: markers,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        zoom: 17,
        target: LatLng(loc.latitude ?? 0, loc.longitude ?? 0),
      ),
      onMapCreated: (GoogleMapController controller) async {
        _mapController = controller;
        _controller.complete(controller);
        await Future.delayed(const Duration(seconds: 2));

        _imageFileGoogleMap = await _mapController!.takeSnapshot();
        isShowMap = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          'Preview Foto',
          textStyle: myTextTheme.headline6?.copyWith(
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: colorBackground,
      body: SafeArea(
        left: false,
        bottom: true,
        right: false,
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: Get.width,
                  child: Center(
                    child: InteractiveViewer(
                      child: RepaintBoundary(
                        key: frameKey,
                        child: Stack(
                          children: [
                            if (widget.image != null)
                              Container(
                                width: Get.width,
                                color: Colors.white,
                                child: ImageFileWidget(
                                  file: widget.image!,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: watermarkItem(widget.loc, widget.placemarks, widget.size),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Opacity(
                                opacity: 0.6,
                                child: SizedBox(
                                    width: size.width * 0.3,
                                    height: size.width * 0.3,
                                    child: _imageFileGoogleMap != null
                                        ? Image.memory(_imageFileGoogleMap!)
                                        : buildGmap(widget.loc, size)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                  width: Get.width,
                  onPressed: () async {
                    try {
                      FocusScope.of(context).unfocus();
                      await Future.delayed(const Duration(seconds: 1));
                      EasyLoading.show(status: 'Processing image...');
                      Uint8List? currentFrame = await getUint8List(frameKey);
                      EasyLoading.show(status: 'Saving...');

                      Directory? dir = await getExternalStorageDirectory();
                      String? path = dir?.path;
                      final file = File('$path/stamp_image_${DateTime.now().toString()}.png');
                      if (await file.exists()) {
                        await file.delete();
                      }
                      file.create();
                      file.writeAsBytesSync(currentFrame!);
                      if (widget.onSuccess != null) {
                        widget.onSuccess!(file);
                      }
                      EasyLoading.dismiss();
                      Get.back();
                    } catch (e) {
                      EasyLoading.dismiss();
                    }
                  },
                  child: CustomText(
                    'Simpan',
                    textStyle: myTextTheme.bodyLarge,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget watermarkItem(LocationData loc, List<geo.Placemark> placemarks, Size size) {
  return Container(
    width: size.width * 0.4,
    padding: const EdgeInsets.all(10),
    child: FittedBox(
      fit: BoxFit.fitWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${loc.latitude}, ${loc.latitude}',
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    Text(
                      placemarks[0].locality.toString() + ', ',
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      placemarks[0].subAdministrativeArea.toString() + ', ',
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      placemarks[0].postalCode.toString() + ', ',
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      placemarks[0].country.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            DateTime.now().toString().toFormattedDateHour(),
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    ),
  );
}
