import 'package:flutter/material.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/subtitle.dart';

class MyAppMethod {
  static Future<void> showErrowWariningDialog({
    required BuildContext context,
    required String subTitle,
    bool isError = false,
    required Function function,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AssetsManager.warning,
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SubtitleTextWidget(
                    label: subTitle,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Visibility(
                        visible: isError,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const SubtitleTextWidget(
                            label: "cancel",
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          function();
                          Navigator.pop(context);
                        },
                        child: const SubtitleTextWidget(
                          label: "Ok",
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}
