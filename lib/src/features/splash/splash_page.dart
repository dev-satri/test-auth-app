import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/core/routes/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _toNext();
    super.initState();
  }

  void _toNext() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.replaceRoute(LoginRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Splash Page')));
  }
}
