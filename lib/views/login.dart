import 'package:event_management_app/auth.dart';
import 'package:event_management_app/constants/colors.dart';
import 'package:event_management_app/containers/custom_input_form.dart';
import 'package:event_management_app/views/homepage.dart';
import 'package:event_management_app/views/signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "Войти",
              style: TextStyle(
                  color: kLightGreen,
                  fontSize: 32,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _emailController,
                icon: Icons.email_outlined,
                label: "Email",
                hint: "Введите ваш email"),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
                obscureText: true,
                controller: _passwordController,
                icon: Icons.lock_outline_rounded,
                label: "Пароль",
                hint: "Введите ваш пароль"),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Забыли пароль",
                  style: TextStyle(
                      color: kLightGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  loginUser(_emailController.text, _passwordController.text)
                      .then((value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Вход выполнен!")));

                      Future.delayed(
                          Duration(seconds: 2),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage())));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Вход не выполнен. Попробуйте снова")));
                    }
                  });
                },
                child: Text("Войти"),
                style: OutlinedButton.styleFrom(
                    foregroundColor: kLightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Создать новый аккаунт?",
                    style: TextStyle(
                        color: kLightGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Зарегистрироваться",
                    style: TextStyle(
                        color: kLightGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
