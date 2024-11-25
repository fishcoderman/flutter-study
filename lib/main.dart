import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InAppWebView Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late InAppWebViewController webViewController;
  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InAppWebView Example"),
      ),
      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(url: Uri.parse("https://flutter.dev")),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStop: (controller, url) async {
          // 当网页加载完成后，调用 JavaScript 函数
          await controller.evaluateJavascript(source: "javascriptFunction();");
        },
        // 使用 onJsCallback 创建 JavaScript 通道
        // onJsCallback: (controller, message) {
        //   // 处理来自 JavaScript 的消息
        //   print("Message from JavaScript: ${message.message}");
        // },
      ),
    );
  }
}