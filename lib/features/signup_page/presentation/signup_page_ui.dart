import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:event_management_app/features/login_page/presentation/widgets/form_container.dart';
import '../../meetup_page/domain/freezed_users/user.dart';

Future createUser({required User body}) async {
  try {
    final pb = PocketBase('http://192.168.0.102:8090');
    final record = await pb.collection('users').create(body: body.toJson());
  } catch (e) {
    rethrow;
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final passwordConfirm = _passwordConfirmController.text;
    await createUser(
        body: User(
            username: username,
            email: email,
            password: password,
            passwordConfirm: passwordConfirm));
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmController.clear();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Логин не может быть пустым";
    } else if (value.length < 3) {
      return "Логин должен быть не менее 3 символов";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email не может быть пустым";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Введите корректный Email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Пароль не может быть пустым";
    } else if (value.length < 6) {
      return "Пароль должен быть не менее 6 символов";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Пароль не может быть пустым";
    } else if (value != _passwordController.text) {
      return "Пароли не совпадают";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                const Text(
                  "Регистрация",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                CustomFormWidget(
                  controller: _usernameController,
                  obscureText: false,
                  icon: Icons.person_outline,
                  label: "Логин",
                  hint: "Придумайте логин",
                  validator: _validateUsername,
                ),
                const SizedBox(height: 8),
                CustomFormWidget(
                  controller: _emailController,
                  obscureText: false,
                  icon: Icons.email_outlined,
                  label: "Email",
                  hint: "Введите ваш Email",
                  validator: _validateEmail,
                ),
                const SizedBox(height: 8),
                CustomFormWidget(
                  controller: _passwordController,
                  obscureText: true,
                  icon: Icons.lock_outline_rounded,
                  label: "Пароль",
                  hint: "Введите пароль",
                  validator: _validatePassword,
                ),
                const SizedBox(height: 8),
                CustomFormWidget(
                  controller: _passwordConfirmController,
                  obscureText: true,
                  icon: Icons.lock_outline_rounded,
                  label: "Подтвердите пароля",
                  hint: "Подтвердите пароль",
                  validator: _validateConfirmPassword,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (_formKey.currentState!.validate()) {
                          await _register();
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Пользователь зарегистрирован'),
                          ));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Произошла ошибка!'),
                        ));
                        rethrow;
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Зарегистрироваться",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Уже есть аккаунт?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Войти",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
