import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var _loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: 'https://flutter.dev',
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
          },
          onPageStarted: (url) {
            setState(() {
              _loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              _loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _loadingPercentage = 100;
            });
          },
          navigationDelegate: (navigation) {
            final host = Uri.parse(navigation.url).host;

            if (host.contains('youtube.com')) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Blocking navigation to $host')));

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: _createJavascriptChannels(context),
        ),
        if (_loadingPercentage < 100)
          LinearProgressIndicator(
            value: _loadingPercentage / 100.0,
          )
      ],
    );
  }

  Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
    return {
      JavascriptChannel(
          name: 'SnackBar',
          onMessageReceived: (message) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message.message)));
          })
    };
  }
}