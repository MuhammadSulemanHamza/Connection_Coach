import 'package:connection_coach/screens/audio_player_screen.dart';
import 'package:connection_coach/screens/text_screen.dart';
import 'package:connection_coach/screens/video_player_screen.dart';
import 'package:connection_coach/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Coaching'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                MyCard(
                  index: 0,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => TextScreen(
                          textData: kCardOneText,
                          appBarTitle: kButtonsNames[0],
                        ),
                      ),
                    );
                  },
                ),
                MyCard(
                  index: 1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => TextScreen(
                          textData: kCardTwoText,
                          appBarTitle: kButtonsNames[1],
                          button: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              alignment: Alignment.topLeft,
                            ),
                            onPressed: () {
                              _launchURL(kWebsiteLink);
                            },
                            child: const Text(
                              kWebsiteLink,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                MyCard(
                  index: 2,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const AudioPlayerScreen(
                          audioFilePaths: [
                            kCard3audio1,
                            kCard3audio2,
                          ],
                        ),
                      ),
                    );
                  },
                ),
                MyCard(
                  index: 3,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const VideoPlayerScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                MyCard(
                  index: 4,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const AudioPlayerScreen(
                          audioFilePaths: [
                            kCard5audio1,
                            kCard5audio2,
                            kCard5audio3,
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: const Color(0xFFFECCD1),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              kButtonsNames[5],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.facebook,
                                      size: 50,
                                      color: Colors.black87,
                                    ),
                                    onPressed: () => _launchURL(kFacebookLink),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.instagram,
                                      size: 50,
                                      color: Colors.black87,
                                    ),
                                    onPressed: () => _launchURL(kInstagramLink),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String urlString) async {
    await canLaunch(urlString)
        ? await launch(urlString)
        : throw 'Could not launch $urlString';
  }
}

class MyCard extends StatelessWidget {
  final int index;
  final Function() onTap;

  const MyCard({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFFFECCD1),
              padding: const EdgeInsets.all(8),
            ),
            onPressed: onTap,
            child: Text(
              kButtonsNames[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
