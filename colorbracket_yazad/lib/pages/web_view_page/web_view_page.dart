import 'package:colorbracket_yazad/utlis/utlis.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String? webUrl;

  WebViewPage({Key? key, required this.webUrl}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> with SingleTickerProviderStateMixin{
  Size? size;
  Orientation? orientation;
  late final WebViewController _controller;
  bool? isLoading = true;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..clearCache()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            Constants.debugLog(WebViewPage, "progress:$progress");
            if (progress == 100) {
              isLoading = false;
              setState(() {

              });
            } else {
              isLoading = true;
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webUrl ?? ""));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(Icons.arrow_back_ios,color: Colors.white),
            //replace with our own icon data.
          ),
          leadingWidth: 35,
          automaticallyImplyLeading: false,
        ),
        body: Theme(
          data: Theme.of(context),
          child: Visibility(
            visible: isLoading ?? true,
            replacement: WebViewWidget(controller: _controller),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handle_back_press() async {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
