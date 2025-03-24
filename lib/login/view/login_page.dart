import 'package:demo_bloc/home/view/home_page.dart';
import 'package:demo_bloc/login/bloc/login_bloc.dart';
import 'package:demo_bloc/login/bloc/login_event.dart';
import 'package:demo_bloc/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
            LoginSubmitted(
              _usernameController.text.trim(),
              _passwordController.text.trim(),
          ),
          );
    }
  }
  
 @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
        } else if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error desconocido')),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock, size: 80, color: Colors.teal),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) => value!.isEmpty ? 'Ingrese el usuario' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Ingrese la contraseña' : null,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed:
                            state.status == LoginStatus.loading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: state.status == LoginStatus.loading
                            ? const CircularProgressIndicator()
                            : const Text('Ingresar',
                                style: TextStyle(fontSize: 16)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

