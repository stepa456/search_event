import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Wire {
  final String color;
  final int lenght;
  final String type;

  Wire({required this.color, required this.lenght, required this.type});
}

class Meetup {
  final int id;
  final String description;
  final String title;
  final DateTime startData;
  final DateTime endData;
  final String picture;
  final String location;

  List<Speches> spechess;

  Meetup({
    required this.id,
    required this.description,
    required this.title,
    required this.startData,
    required this.endData,
    required this.picture,
    required this.location,
    required this.spechess,
  });
}

class Speches {
  final int id;
  final DateTime time;
  final String theme;
  final String description;

  List<Actor> actors;

  Speches({
    required this.id,
    required this.time,
    required this.theme,
    required this.description,
    required this.actors,
  });
}

class Actor {
  final int id;
  final String jobName;
  final String firstName;
  final String lastName;
  final String picture;

  Actor({
    required this.id,
    required this.jobName,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });
}

final meetup = [
  Meetup(
      description: "Hello world!",
      endData: DateTime.parse("2005-04-24 11:03:02"),
      id: 1,
      location: "Cherepovec",
      picture:
          "https://www.ktbbeton.com/upload/webp/resize_cache/f6b/485_320_1/eae1afc4cd562088b763f424ebdcebbd.webp",
      spechess: [
        Speches(
          id: 1,
          time: DateTime.parse("2004-04-24 11:03:02"),
          theme: "Coding",
          description: "Create AI",
          actors: [
            Actor(
                id: 2,
                jobName: "Developer",
                firstName: "Vasyli",
                lastName: "Novikov",
                picture:
                    "https://static01.nyt.com/newsgraphics/2020/11/12/fake-people/4b806cf591a8a76adfc88d19e90c8c634345bf3d/fallbacks/mobile-02.jpg")
          ],
        )
      ],
      startData: DateTime.parse("2004-04-24 11:03:02"),
      title: "Halloween"),
  Meetup(
      description: "Welcome",
      endData: DateTime.parse("2004-04-24 11:03:02"),
      id: 1,
      location: "Chelyabinsk",
      picture:
          "https://weekly.uz/wp-content/uploads/2024/02/JulVXy16617527527660_l-1.jpg",
      spechess: [
        Speches(
          id: 1,
          time: DateTime.parse("2004-04-24 11:03:02"),
          theme: "Coding",
          description: "Create web app",
          actors: [
            Actor(
                id: 2,
                jobName: "Developer",
                firstName: "Masha",
                lastName: "Sidorova",
                picture:
                    "https://static01.nyt.com/newsgraphics/2020/11/12/fake-people/4b806cf591a8a76adfc88d19e90c8c634345bf3d/fallbacks/mobile-07.jpg")
          ],
        )
      ],
      startData: DateTime.parse("2004-04-06 11:03:02"),
      title: "Halloween"),
  Meetup(
      description: "Develop android app",
      endData: DateTime.parse("2004-04-07 11:03:02"),
      id: 1,
      location: "Moscow",
      picture:
          "https://assets-global.website-files.com/656ff1f91e50b62c0eb86d15/656ff1f91e50b62c0eb86e62_About-Us-Body-Image-5-800x600px.jpg",
      spechess: [
        Speches(
          id: 1,
          time: DateTime.parse("2004-04-06 11:03:02"),
          theme: "Development",
          description: "Create mobile app",
          actors: [
            Actor(
                id: 2,
                jobName: "Developer",
                firstName: "Petya",
                lastName: "Ivanov",
                picture:
                    "https://i.dailymail.co.uk/1s/2023/09/15/10/75464653-0-image-a-11_1694769022984.jpg")
          ],
        )
      ],
      startData: DateTime.parse("2004-04-24 11:03:02"),
      title: "New year")
];

class MeetupsPage extends StatelessWidget {
  const MeetupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meetups'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Padding(padding: EdgeInsets.only(top: 8)),
              itemCount: meetup.length,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: meetup[index].picture,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      ListTile(
                          title: Text(meetup[index].title),
                          subtitle: Text(
                            meetup[index].description,
                          ))
                    ],
                  ),
                );
              }),
        ));
  }
}
