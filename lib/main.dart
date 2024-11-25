import 'package:flutter/material.dart';
import 'api_service.dart';
import 'webview_page.dart'; // 导入 WebView 页

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService();
  String title = "点击按钮获取数据";

  void _getData() async {
    try {
      final data = await apiService.fetchPost();
      setState(() {
        title = data['title']; // 获取并显示标题
      });
    } catch (e) {
      setState(() {
        title = "获取数据失败: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter API Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getData,
              child: Text("获取数据"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WebViewPage()),
                );
              },
              child: Text("打开 WebView"),
            ),
          ],
        ),
      ),
    );
  }
}