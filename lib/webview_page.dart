import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  // 发送消息到 WebView
  void _sendMessageToWebView() {
    _controller.runJavascript('flutterMessage("Hello from Flutter!");');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView Example"),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessageToWebView, // 发送消息按钮
          ),
        ],
      ),
      body: WebView(
        initialUrl: 'http://127.0.0.1:63210/index.html', // 替换为你的远程URL
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            name: 'Flutter',
            onMessageReceived: (JavascriptMessage message) {
              // 接收来自 WebView 的消息
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message.message)),
              );
            },
          ),
        },
      ),
    );
  }
}
