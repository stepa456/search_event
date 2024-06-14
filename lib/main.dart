import 'package:event_management_app/features/login_page/presentation/login_page_ui.dart';
import 'package:event_management_app/features/meetup_page/presentation/create_meetup_ui.dart';
import 'package:flutter/material.dart';
import 'package:event_management_app/features/signup_page/presentation/signup_page_ui.dart';
import 'package:event_management_app/features/home_page/presentation/home_page_ui.dart';

import 'features/meetup_page/presentation/detail_info_meetup_ui.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo app',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 198, 232, 198),
            brightness: Brightness.light),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/create': (context) => const CreateNewMeetup(),
        '/login': (context) => const LoginPage(),
        '/homepage': (context) => const HomePage(),
        '/detail': (context) => const DetailInformationMeetup(),
        '/signUp': (context) => const SignUpPage(),
        '/': (context) => const HomePage(),
      },
    );
  }
}
