import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'battery_controller.dart';

class BatteryPage extends StatelessWidget {
  BatteryPage({super.key});
  final BatteryController controller = Get.put(BatteryController());

  @override
  Widget build(BuildContext context) {
    double indicatorHeight = Get.height * 0.25;

    double calcIndicatorHeight(int level) {
      if ((level < 0) && (level > 100)) {
        //-error from native cals
        return indicatorHeight;
      } else {
        //real data
        return indicatorHeight - (indicatorHeight * controller.batteryLevel.value) / 100;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Charge Status'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text("Battery status", style: TextStyle(fontSize: 14, color: Colors.black)),
            const SizedBox(height: 16),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: Get.width * 0.33,
                    height: Get.height * 0.25,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    left: 2,
                    right: 2,
                    top: calcIndicatorHeight(controller.batteryLevel.value),
                    child: Container(
                      width: Get.width * 0.30,
                      height: Get.height * 0.25,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(controller.batteryLevelResult.value, style: TextStyle(fontSize: 14, color: Colors.black)),
            const SizedBox(height: 16),
            SizedBox(
              width: Get.width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 2.0, color: Colors.green),
                ),
                onPressed: () => controller.getBatteryCharge(),
                child: const Text('Check Battery Level'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
