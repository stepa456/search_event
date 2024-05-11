import 'package:event_management_app/auth.dart';
import 'package:event_management_app/constants/colors.dart';
import 'package:event_management_app/containers/custom_input_form.dart';
import 'package:event_management_app/views/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
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
              "Зарегистрироваться",
              style: TextStyle(
                  color: kLightGreen,
                  fontSize: 32,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _nameController,
                icon: Icons.person_outline,
                label: "Имя",
                hint: "Введите ваше имя"),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _emailController,
                icon: Icons.email_outlined,
                label: "Email",
                hint: "Введите ваш Email"),
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
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  createUser(_nameController.text, _emailController.text,
                          _passwordController.text)
                      .then((value) {
                    if (value == "success") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Аккаунт зарегистрирован")));
                      Future.delayed(
                          Duration(seconds: 2),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage())));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(value)));
                    }
                  });
                },
                child: Text("Зарегистрироваться"),
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
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Уже есть аккаунт?",
                    style: TextStyle(
                        color: kLightGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Войти",
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
