// Native permission handler using platform channels
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class NativePermissionHandler {
  static const MethodChannel _channel = MethodChannel('app.permissions/camera');

  static Future<bool> checkCameraPermission() async {
    if (Platform.isIOS) {
      try {
        final bool hasPermission = await _channel.invokeMethod('checkCameraPermission');
        return hasPermission;
      } on PlatformException catch (e) {
        return false;
      }
    }
    // For Android, assume permission is granted (handled by the scanner package)
    return true;
  }

  static Future<bool> requestCameraPermission() async {
    if (Platform.isIOS) {
      try {
        final bool granted = await _channel.invokeMethod('requestCameraPermission');
        return granted;
      } on PlatformException catch (e) {
        return false;
      }
    }
    return true;
  }

  static Future<void> openAppSettings() async {
    if (Platform.isIOS) {
      try {
        await _channel.invokeMethod('openSettings');
      } on PlatformException catch (e) {
        print('Failed to open settings: ${e.message}');
      }
    }
  }
}