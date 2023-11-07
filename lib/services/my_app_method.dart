import 'package:flutter/material.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class MyAppMethod {
  static Future<void> showErrowWariningDialog({
     required BuildContext context ,
    required String subTitle,
      double fontsize=28,
    bool isError = false,
    required Function function,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
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
                    fontSize: fontsize,
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

  static Future<void> imagePickerDialog(
      {required BuildContext context,
      required Function imageFCT,
      required Function removeFCT,
      required Function cameraFCT}) async {
    await showDialog(
        context: (context),
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: const Center(child: TitleTextWidget(label: "chose option")),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      cameraFCT();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.camera),
                    label: const TitleTextWidget(label: 'camera'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      imageFCT();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const TitleTextWidget(label: 'Gallery'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      removeFCT();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.remove),
                    label: const TitleTextWidget(label: 'Remove'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
