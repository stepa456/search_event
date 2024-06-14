import 'package:flutter/material.dart';
import 'package:event_management_app/features/login_page/presentation/widgets/form_container.dart';
import 'package:pocketbase/pocketbase.dart';

Future authUser({required String username, required String password}) async {
  try {
    final pb = PocketBase('http://192.168.0.102:8090');
    final record =
        await pb.collection('users').authWithPassword(username, password);
  } catch (e) {
    print('Пользователя не существует');
    rethrow;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Логин не может быть пустым";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Пароль не может быть пустым";
    }
    return null;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _authUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    await authUser(username: username, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Войти",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 8,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    CustomFormWidget(
                      controller: _usernameController,
                      obscureText: false,
                      icon: Icons.person_outline,
                      label: "Логин",
                      hint: "Введите логин",
                      validator: _validateUsername,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomFormWidget(
                      controller: _passwordController,
                      obscureText: true,
                      icon: Icons.lock_outline_rounded,
                      label: "Пароль",
                      hint: "Введите пароль",
                      validator: _validatePassword,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Забыли пароль?",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      try {
                        _authUser;
                        Navigator.pushNamed(context, '/homepage');
                      } catch (e) {
                        rethrow;
                      }
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    "Войти",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Нет аккаунта?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    child: const Text(
                      "Зарегистрироваться",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
