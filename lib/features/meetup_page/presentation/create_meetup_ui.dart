import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:event_management_app/features/meetup_page/domain/freezed/meetup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

Future createMeetup(
    {required CreateMeetupDTO createMeetupDto,
    required List<File> pictures}) async {
  final pb = PocketBase('http://192.168.0.102:8090');
  try {
    final multipartFiles = await Future.wait(
      pictures.map((picture) async {
        return await http.MultipartFile.fromPath('picture', picture.path,
            filename: picture.path.split("/").last);
      }).toList(),
    );

    final record = await pb.collection('meetups').create(
          body: createMeetupDto.toJson(),
          files: multipartFiles,
        );
    print(record.data);
  } catch (e) {
    log('Ошибка создания митапа', error: e);
    rethrow;
  }
}

class CreateNewMeetup extends StatefulWidget {
  const CreateNewMeetup({super.key});

  @override
  State<CreateNewMeetup> createState() => _CreateNewMeetupState();
}

class _CreateNewMeetupState extends State<CreateNewMeetup> {
  final _formKey = GlobalKey<FormState>();
  final List<File> imageList = [];
  File? selectedImageMeetup;

  //info meetup main
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  //info data Speches
  final _speechThemeController = TextEditingController();
  final _speechDescriptionController = TextEditingController();

  //info data Actors
  final _actorsJobTitle = TextEditingController();
  final _actorsFirstName = TextEditingController();
  final _actorsLastName = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateStartController.dispose();
    _dateEndController.dispose();
    _locationController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _addMeetup() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final startData = _dateStartController.text;
    final endData = _dateEndController.text;
    final phone = _phoneNumberController.text;
    final location = _locationController.text;

    // info data Speches
    final speechTheme = _speechThemeController.text;
    final speechDescription = _speechDescriptionController.text;

    // info data Actors
    final jobName = _actorsJobTitle.text;
    final actorsFirstName = _actorsFirstName.text;
    final actorsLastName = _actorsLastName.text;

    final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    final DateTime startDataStr = dateFormat.parse(startData);
    final DateTime endDataStr = dateFormat.parse(endData);

    try {
      await createMeetup(
        createMeetupDto: CreateMeetupDTO(
          description: description,
          title: title,
          startData: startDataStr,
          endData: endDataStr,
          location: location,
          phone: phone,
        ),
        pictures: imageList,
      );

      _formKey.currentState!.reset();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Новый  митап',
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/homepage');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Stack(children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Название митапа',
                          hintText: 'Назовите митап',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.length < 3) {
                            return 'Название должно быть больше 3 символов';
                          } else if (value.length > 50) {
                            return 'Название превышать 50 символов';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            labelText: 'Описание митапа',
                            hintText: 'Придумайте описание митапа',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value!.length < 10) {
                            return 'Описание должно быть больше 10 символов';
                          } else if (value.length > 100) {
                            return 'Описание не должно быть больше 100 символов';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _dateStartController,
                        readOnly: true,
                        decoration: const InputDecoration(
                            labelText: 'Дата и время начала',
                            hintText: 'Когда начинается меропритие?',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Поле не может быть пустым';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              DateTime fullDateTime = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy HH:mm')
                                      .format(fullDateTime);
                              setState(() {
                                _dateStartController.text = formattedDate;
                              });
                            }
                          } else {
                            'Дата и время не выбраны';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _dateEndController,
                        readOnly: true,
                        decoration: const InputDecoration(
                            labelText: 'Дата и время завершения',
                            hintText: 'Когда заканчивается митап?',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Поле не может быть пустым';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              DateTime fullDateTime = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy HH:mm')
                                      .format(fullDateTime);
                              setState(() {
                                _dateEndController.text = formattedDate;
                              });
                            }
                          } else {
                            'Дата не выбрана';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Откуда выбрать фото?'),
                                    actions: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  selectedImageMeetup =
                                                      await _pickImageFromGallery()
                                                          .then((File? value) {
                                                    setState(() {
                                                      imageList.add(value!);
                                                    });
                                                    return null;
                                                  });
                                                },
                                                child: const Column(
                                                  children: [
                                                    Icon(
                                                      Icons.image,
                                                      size: 80,
                                                    ),
                                                    Text(
                                                      'Галлерея',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  _pickImageFromCamera().then(
                                                      (File? pickedImage) =>
                                                          setState(() {
                                                            imageList.add(
                                                                pickedImage!);
                                                          }));
                                                },
                                                child: const Column(
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      size: 80,
                                                    ),
                                                    Text(
                                                      'Камера',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const SizedBox(
                                width: 100,
                                height: 100,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate,
                                        size: 40,
                                      ),
                                      Text(
                                        'Добавить фото',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: Row(
                                  children: [
                                    if (imageList.isNotEmpty) ...[
                                      for (int i = 0;
                                          i < imageList.length;
                                          i++) ...[
                                        Card(
                                          child: SizedBox(
                                            width: 90,
                                            height: 90,
                                            child: ClipRRect(
                                              clipBehavior: Clip.hardEdge,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: Image.file(
                                                File(imageList[i].path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      // TextFormField(
                      //     controller: _locationController,
                      //     decoration: const InputDecoration(
                      //         labelText: 'Место проведения',
                      //         hintText:
                      //             'По какому адресу будет проходить митап?',
                      //         border: OutlineInputBorder()),
                      //     validator: (value) {
                      //       if (value!.length < 5) {
                      //         return 'Слишком короткий адрес мин. 5 символов';
                      //       } else if (value.length > 100) {
                      //         return 'Слишком длинный адрес макс. 100 символов';
                      //       } else {
                      //         return null;
                      //       }
                      //     }),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //     controller: _phoneNumberController,
                      //     decoration: const InputDecoration(
                      //         labelText: 'Номер телефона для записи',
                      //         hintText: 'Номер телефона',
                      //         border: OutlineInputBorder()),
                      //     validator: (value) {
                      //       if (value!.length < 11) {
                      //         return 'Номер телефона не должен быть меньше 11 цифр';
                      //       } else if (value.length > 11) {
                      //         return 'Номер телефона не должен быть больше 11 цифр';
                      //       } else {
                      //         return null;
                      //       }
                      //     }),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //   controller: _speechThemeController,
                      //   decoration: const InputDecoration(
                      //       labelText: 'Тема выступления',
                      //       hintText: 'На какую тему будет выступление?',
                      //       border: OutlineInputBorder()),
                      //   validator: (value) {
                      //     if (value!.length < 5) {
                      //       return 'Тема должна быть больше 5 символов';
                      //     } else if (value.length > 30) {
                      //       return 'Тема не должно быть больше 50 символов';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //   controller: _speechDescriptionController,
                      //   decoration: const InputDecoration(
                      //       labelText: 'Подробнее о выступлении',
                      //       hintText: 'Напиши описание выступления',
                      //       border: OutlineInputBorder()),
                      //   validator: (value) {
                      //     if (value!.length < 5) {
                      //       return 'Описание не должно быть больше 5 символов';
                      //     } else if (value.length > 100) {
                      //       return 'Описание не должно быть больше 100 символов';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //   controller: _actorsJobTitle,
                      //   decoration: const InputDecoration(
                      //       labelText: 'Должность спикера',
                      //       hintText: 'Напишите должность',
                      //       border: OutlineInputBorder()),
                      //   validator: (value) {
                      //     if (value!.length < 2) {
                      //       return 'Должность не может быть меньше 2 символов!';
                      //     } else if (value.length > 30) {
                      //       return 'Должность не может быть больше 30 символов!';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //   controller: _actorsFirstName,
                      //   decoration: const InputDecoration(
                      //       labelText: 'Имя спикера',
                      //       hintText: 'Имя',
                      //       border: OutlineInputBorder()),
                      //   validator: (value) {
                      //     if (value!.length < 2) {
                      //       return 'Слишком короткое имя';
                      //     } else if (value.length > 30) {
                      //       return 'Слишком длинное имя';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //   controller: _actorsLastName,
                      //   decoration: const InputDecoration(
                      //       labelText: 'Фамилия спикера',
                      //       hintText: 'Фамилия',
                      //       border: OutlineInputBorder()),
                      //   validator: (value) {
                      //     if (value!.length < 5) {
                      //       return 'Фамилия слишком короткая';
                      //     } else if (value.length > 30) {
                      //       return 'Фамилия слишком длинная';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),

                      ElevatedButton(
                        onPressed: () async {
                          try {
                            if (_formKey.currentState!.validate()) {
                              await _addMeetup();
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Митап добавлен!'),
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
                        child: const Text(
                          'Добавить',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    ));
  }

  //Gallery
  Future<File?> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Navigator.of(context).pop();
      return File(pickedImage.path);
    }
    return null;
  }

  //Camera
  Future<File?> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      Navigator.of(context).pop();
      return File(pickedImage.path);
    }
    return null;
  }
}
