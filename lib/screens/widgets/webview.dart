import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:textile/screens/widgets/drawer.dart';



class MoreWebview extends StatefulWidget {
  const MoreWebview({Key? key, required this.title, required this.url})
      : super(key: key);
  final String? title;
  final String url;

  @override
  _MoreWebviewState createState() => _MoreWebviewState();
}

class _MoreWebviewState extends State<MoreWebview> {
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(isloading ? 'Loading....' : widget.title ?? ''),
        backgroundColor: const Color(0xff312783),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            gestureNavigationEnabled: true,
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            allowsInlineMediaPlayback: true,
            onPageStarted: (finish) {
              setState(() {
                isloading = false;
              });
            },
          ),
          isloading
              ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red,),strokeWidth:2.0,),
          )
              : Stack(),
        ],
      ),
    );
  }
}
