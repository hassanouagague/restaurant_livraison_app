import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:food_livraison_app/routes/route_constant.dart';
import 'package:food_livraison_app/theme/theme_text_style.dart';

import '../../theme/theme_colors.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);
// webviewscreen
  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300.w,
              padding: EdgeInsets.all(20.r),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r), // <-- Radius
                      ),
                      primary: ThemeColors.primary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10.h)),
                  onPressed: () {
                    Get.toNamed(RouteConstant.login);
                  },
                  child: Text(
                    "se connecter",
                    style: ThemeTextStyle().label,
                  )),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse(Get.arguments ?? "")),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions()),
                onWebViewCreated: (InAppWebViewController controller) {},
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {},
                onLoadStop: (InAppWebViewController controller, Uri? uri) {
                  EasyLoading.dismiss();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
