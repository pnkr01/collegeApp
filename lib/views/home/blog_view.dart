import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'nav_bars/error.dart';

class BlogView extends StatefulWidget {
  final String? blogUrl;
  final String? title;
  const BlogView({Key? key, this.blogUrl, this.title}) : super(key: key);

  @override
  _BlogViewState createState() => _BlogViewState();
}

bool spinner = true;

class _BlogViewState extends State<BlogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.brown,
        backgroundColor: const Color(0xff943176),
        title: Text(
          widget.title!,
          style: const TextStyle(
            fontFamily: "Signatra",
            fontSize: 45.0,
          ),
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.safety_divider),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            child: Sizer(
              builder: (BuildContext context, Orientation orientation,
                  DeviceType deviceType) {
                return WebView(
                  allowsInlineMediaPlayback: true,
                  onWebResourceError: (weberror) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ErrorScreen(),
                      ),
                    );
                  },
                  onPageFinished: (url) {
                    setState(() {
                      spinner = false;
                    });
                  },
                  gestureNavigationEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.blogUrl,
                );
              },
            ),
          ),
          spinner
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                )
              : Stack(),
        ],
      ),
    );
  }
}
