import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
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
  WebViewController? _controller; // Cambia a nullable en lugar de late
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebViewController().then((_) {
      // Solo después de inicializar el controlador, solicitamos la URL
      context.read<PaymentUrlBloc>().add(GenerateUrlPaymentEvent(widget.reserveId));
    });
  }

  Future<void> _initializeWebViewController() async {
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
          // Monitorear cambios de URL
        },
      ),
    );

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    setState(() {
      _controller = controller;
    });
  }

  Future<void> _loadUrl(String url) async {
    if (_controller == null) return; // Asegúrate de que el controlador existe
    
    try {
      await _controller!.loadRequest(Uri.parse(url));
      setState(() {
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar la URL: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realizar Pago'),
      ),
      body: BlocListener<PaymentUrlBloc, PaymentUrlState>(
        listener: (context, state) {
          if (state is GenerateUrlPaymentSuccess && _controller != null) {
            _loadUrl(state.url);
          } else if (state is GenerateUrlPaymentError) {
            setState(() {
              _errorMessage = state.message;
              _isLoading = false;
            });
          }
        },
        child: Stack(
          children: [
            if (_controller != null)
              WebViewWidget(controller: _controller!)
            else
              const Center(child: CircularProgressIndicator()),
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
      ),
    );
  }
}