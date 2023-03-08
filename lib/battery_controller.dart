import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BatteryController extends GetxController {
  static const platform = MethodChannel('com.example.battery/battery');

  RxInt batteryLevel = 0.obs;
  RxString batteryLevelResult = 'No info for battery level'.obs;

  Future<void> getBatteryCharge() async {
    try {
      print(batteryLevel.value);
      if (batteryLevel.value == 0) {
        batteryLevelResult.value = "No info for battery level";
      } else {
        batteryLevelResult.value = "${batteryLevel.value.toString()} %";
      }
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel.value = result;
      update();
    } on PlatformException catch (e) {
      print('Failed to get battery level: ${e.message}');
    }
  }
}
