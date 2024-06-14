import 'package:flutter/material.dart';

selectPhoto() {
  return AlertDialog(
    title: const Text(
      'Откуда выбрать фото?',
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: const SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        Icons.image,
                        size: 80,
                      ),
                      Text(
                        'Галлерея',
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: const SizedBox(
                  child: Column(
                    children: [
                      Icon(Icons.camera_alt, size: 80),
                      Text(
                        'Камера',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
