import 'package:flutter/material.dart';

class DetailInformationMeetup extends StatefulWidget {
  const DetailInformationMeetup({super.key});

  @override
  State<DetailInformationMeetup> createState() =>
      _DetailInformationMeetupState();
}

class _DetailInformationMeetupState extends State<DetailInformationMeetup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TextButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            child: const Text(
              'НАЗАД!!!',
              style: TextStyle(),
            )),
      ),
    );
  }
}
