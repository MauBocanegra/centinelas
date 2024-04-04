import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';


class PrivacyPageProvider extends StatefulWidget {
  const PrivacyPageProvider({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.format_color_text,
      name: privacyRoute
  );

  @override
  State<PrivacyPageProvider> createState() => _PrivacyPageProviderState();
}

class _PrivacyPageProviderState extends State<PrivacyPageProvider> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    webViewController =
      WebViewController.fromPlatformCreationParams(params);
    webViewController.loadRequest(
        Uri.parse("https://centinelas-27d9b.web.app")
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            if(context.canPop()){
              context.pop();
            } else {
              context.go('/${LoginPage.pageConfig.name}');
            }
          },
        ),
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
