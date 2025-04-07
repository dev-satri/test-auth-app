import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/di.dart';
import 'package:frontend/src/core/constants/dimes.dart';
import 'package:frontend/src/core/extensions/build_context.dart';
import 'package:frontend/src/core/routes/app_router.gr.dart';
import 'package:frontend/src/features/auth/presentation/blocs/auth_bloc.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(d_2),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              SizedBox(height: d_2),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: d_2),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: d_3),
              BlocConsumer<AuthBloc, AuthState>(
                listenWhen:
                    (p, c) =>
                        p.failure != c.failure ||
                        p.profileModel != c.profileModel,
                listener: (context, state) {
                  if (state.profileModel != null) {
                    context.replaceRoute(ProductRoute());
                  }
                  if (state.failure != null) {
                    context.showSnackbar(state.failure!.message, isError: true);
                  }
                },
                buildWhen:
                    (previous, current) =>
                        previous.isLoading != current.isLoading,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        RegisterEvent(
                          name: _nameController.text.trim(),
                          email: _emailController.text.toLowerCase().trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                    },
                    child:
                        state.isLoading
                            ? CircularProgressIndicator()
                            : Text('Register'),
                  );
                },
              ),

              TextButton(
                onPressed: () {
                  context.replaceRoute(LoginRoute());
                },
                child: Text("Already Registered ? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
