import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class recipeview extends StatefulWidget {
  String? url;
  recipeview(this.url);

  @override
  State<recipeview> createState() => _recipeviewState();
}

class _recipeviewState extends State<recipeview> {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Food Recipe App"),
      ),
      body: Container(),
    );
  }
}
