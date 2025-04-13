import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Importa estas para mejor soporte en iOS/Android
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PaymentPage extends StatefulWidget {
  final int reserveId;
  const PaymentPage({super.key, required this.reserveId});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  final String url = "https://vpay.com.bo:5039/#/lnk/eyJhbGciOiJIUzI1NiIsInR5cCI6ICJKV1QifQ.eyJjb21wYW55SWQiOiI5NSIsImNvZGlnbyI6IjEiLCJtb250byI6MX0";

  @override
  void initState() {
    super.initState();
    _initializeWebViewController();
  }

  Future<void> _initializeWebViewController() async {
    // Configuración avanzada para iOS/Android
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params);

    // Configuración común
    await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    await controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          setState(() {
            _isLoading = progress < 100;
          });
        },
        onPageStarted: (String url) {
          setState(() {
            _isLoading = true;
            _errorMessage = null;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            _isLoading = false;
          });
        },
        onWebResourceError: (WebResourceError error) {
          setState(() {
            _errorMessage = 'Error al cargar la página: ${error.description}';
            _isLoading = false;
          });
        },
        onUrlChange: (UrlChange change) {
          // Puedes monitorear cambios de URL aquí
        },
      ),
    );

    // Configuración específica para Android
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    // Carga la URL
    try {
      await controller.loadRequest(Uri.parse(url));
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar la URL: $e';
        _isLoading = false;
      });
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (_errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}