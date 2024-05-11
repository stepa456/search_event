import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:event_management_app/constants/colors.dart';
import 'package:event_management_app/containers/custom_headtext.dart';
import 'package:event_management_app/containers/custom_input_form.dart';
import 'package:event_management_app/database.dart';
import 'package:event_management_app/saved_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth.dart';
import 'add_photo.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  FilePickerResult? _filePickerResult;
  Uint8List? _webImagePickerResult;
  File? _selectedImage;
  bool _isInPersonEvent = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _guestController = TextEditingController();
  final TextEditingController _sponsersController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  Storage storage = Storage(client);
  bool isUploading = false;
  String userId = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    userId = SavedData.getUserId();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // To pickup date and time form the user

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute);
        setState(() {
          _dateTimeController.text = selectedDateTime.toString();
        });
      }
    }
  }

  void pickImageForCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });

    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles(type: FileType.image);
    // setState(() {
    //   _filePickerResult = result;
    // });
  }

// upload event image to storage bucket

  Future uploadEventImage() async {
    setState(() {
      isUploading = true;
    });
    try {
      if (_selectedImage != null) {
        final fileByes = await _selectedImage!.readAsBytes();
        final inputFile =
            InputFile.fromBytes(bytes: fileByes, filename: "event_image");

        final response = await storage.createFile(
            bucketId: '663730ee0028f6f30b6b',
            fileId: ID.unique(),
            file: inputFile);
        print(response.$id);
        return response.$id;
      } else {
        print("Что-то пошло не так");
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

// image picker for web platform
  void pickImageForGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });

    // Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    // if (bytesFromPicker != null) {
    //   setState(() {
    //     _webImagePickerResult = bytesFromPicker;
    //   });
    // }
  }

  // upload image for web platform
  Future uploadImageWeb() async {
    try {
      if (_webImagePickerResult != null) {
        final inputFile = InputFile.fromBytes(
            bytes: _webImagePickerResult!, filename: "event_image.jpg");

        final response = await storage.createFile(
            bucketId: '663730ee0028f6f30b6b',
            fileId: ID.unique(),
            file: inputFile);
        print(response.$id);
        return response.$id;
      } else {
        print("Что-то пошло не так");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 50,
            ),
            CustomHeadText(text: "Добавить мероприятие"),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                if (kIsWeb) {
                } else {}
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                    color: kLightGreen, borderRadius: BorderRadius.circular(8)),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.fill,
                        ),
                      )
                    : _webImagePickerResult != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              _webImagePickerResult!,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 42,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Добавить фото",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              ]),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _nameController,
                icon: Icons.event_outlined,
                label: "Название мероприятия",
                hint: "Добавить название мероприятия"),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
                maxLines: 4,
                controller: _descController,
                icon: Icons.description_outlined,
                label: "Описание",
                hint: "Добавить описание"),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _locationController,
                icon: Icons.location_on_outlined,
                label: "Местоположение",
                hint: "Введите место проведения мероприятия"),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
              controller: _dateTimeController,
              icon: Icons.date_range_outlined,
              label: "Дата и Время",
              hint: "Дата и Время",
              readOnly: true,
              onTap: () => _selectDateTime(context),
            ),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _guestController,
                icon: Icons.people_outlined,
                label: "Гости",
                hint: "Введите список гостей"),
            SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _sponsersController,
                icon: Icons.attach_money_outlined,
                label: "Спонсоры",
                hint: "Введите спонсоров"),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "Личное мероприятие",
                  style: TextStyle(color: kLightGreen, fontSize: 20),
                ),
                Spacer(),
                Switch(
                    activeColor: kLightGreen,
                    focusColor: Colors.green,
                    value: _isInPersonEvent,
                    onChanged: (value) {
                      setState(() {
                        _isInPersonEvent = value;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: MaterialButton(
                color: kLightGreen,
                onPressed: () {
                  if (_nameController.text == "" ||
                      _descController.text == "" ||
                      _locationController.text == "" ||
                      _dateTimeController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Название события, описание, местоположение, дата и время обязательны.")));
                  } else {
                    if (kIsWeb) {
                      uploadImageWeb()
                          .then((value) => createEvent(
                              _nameController.text,
                              _descController.text,
                              value,
                              _locationController.text,
                              _dateTimeController.text,
                              userId,
                              _isInPersonEvent,
                              _guestController.text,
                              _sponsersController.text))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Мероприятие добавлено!")));
                        Navigator.pop(context);
                      });
                    } else {
                      uploadEventImage()
                          .then((value) => createEvent(
                              _nameController.text,
                              _descController.text,
                              value,
                              _locationController.text,
                              _dateTimeController.text,
                              userId,
                              _isInPersonEvent,
                              _guestController.text,
                              _sponsersController.text))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Меропритие добавлено!")));
                        Navigator.pop(context);
                      });
                    }
                  }
                },
                child: Text(
                  "Создать новое мероприятие",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
