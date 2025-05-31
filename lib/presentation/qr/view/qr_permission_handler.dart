import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

mixin QrPermissionHandler<T extends StatefulWidget> on State<T> {
  bool hasPermission = false;

  Future<void> checkCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      setState(() {
        hasPermission = true;
      });
    } else {
      final result = await Permission.camera.request();
      setState(() {
        hasPermission = result.isGranted;
      });
    }
  }
}
