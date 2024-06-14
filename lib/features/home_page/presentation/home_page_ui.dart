import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import '../../login_page/presentation/login_page_ui.dart';
import '../../meetup_page/domain/freezed/meetup.dart';

Future<List<Meetup>> getMeetups() async {
  try {
    final pb = PocketBase('http://192.168.0.102:8090');
    await pb.collection('users').authWithPassword('test1@mail.ru', '1qazxsw2');
    final records = await pb.collection('meetups').getFullList(
          sort: '-created',
        );
    final List<Meetup> meetups = [];
    for (var record in records) {
      final meetup = Meetup.fromRecord(record);
      meetups.add(meetup);
    }
    return meetups;
  } catch (error, stackTrace) {
    log('Наша ошибка', error: error, stackTrace: stackTrace);
    rethrow;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final myFuture = getMeetups();
  List<bool> isExpandList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Все митапы",
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed('/create');
          },
          label: const Text('Добавить'),
        ),
        body: FutureBuilder<List<Meetup>>(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                // Initialize the isExpandList based on the number of meetups
                if (isExpandList.length != snapshot.data!.length) {
                  isExpandList =
                      List<bool>.filled(snapshot.data!.length, false);
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final meetup = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpandList[index] = !isExpandList[index];
                          });
                        },
                        onDoubleTap: () {
                          Navigator.of(context).pushNamed('/detail');
                        },
                        child: AnimatedContainer(
                          height: isExpandList[index] ? 800 : 350,
                          curve: Curves.linear,
                          duration: const Duration(milliseconds: 375),
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: meetup.pictures.length == 1
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              'http://192.168.0.102:8090/api/files/5m58yr4lkq0h0yh/${meetup.id}/${meetup.pictures[0]}',
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        )
                                      : CarouselSlider.builder(
                                          options: CarouselOptions(
                                            height: 200,
                                            autoPlay: true,
                                            enlargeCenterPage: true,
                                            viewportFraction: 1.0,
                                          ),
                                          itemCount: meetup.pictures.length,
                                          itemBuilder: (context, pictureIndex,
                                              realIndex) {
                                            final pictureUrl =
                                                'http://192.168.0.102:8090/api/files/5m58yr4lkq0h0yh/${meetup.id}/${meetup.pictures[pictureIndex]}';
                                            return CachedNetworkImage(
                                              imageUrl: pictureUrl,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              height: 200,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(
                                      meetup.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text.rich(
                                      maxLines: isExpandList[index] ? 30 : 3,
                                      overflow: TextOverflow.ellipsis,
                                      TextSpan(
                                        text: meetup.description,
                                        children: [
                                          TextSpan(
                                            text:
                                                '\nАдрес: ${meetup.location}\n\nНачало: ${meetup.startData}\n\nНомер телефона: ${meetup.phone}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (isExpandList[index])
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/detail');
                                    },
                                    child: const SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Card(
                                          color: Colors.blueAccent,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Подробнее',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          )),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: snapshot.data?.length ?? 0,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Текст ошибки: ${snapshot.error}');
              }
            }
            return const Padding(
              padding: EdgeInsets.all(30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Загрузка...'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
