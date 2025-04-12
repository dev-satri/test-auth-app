import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/core/local/local_storage.dart';
import 'package:frontend/src/core/local/storage_keys.dart';
import 'package:frontend/src/core/routes/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final LocalStorageService _localStorageService = LocalStorageService();

  @override
  void initState() {
    _toNext();
    super.initState();
  }

  void _toNext() {
    final token = _localStorageService.read(StorageKeys.authToken);

    Future.delayed(const Duration(seconds: 2), () {
      if (token != null) {
        if (mounted) context.replaceRoute(ProductRoute());
      } else {
        if (mounted) context.replaceRoute(LoginRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Splash Page')));
  }
}
