import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:connection_coach/notifiers/play_button_notifier.dart';
import 'package:connection_coach/notifiers/progress_notifier.dart';
import 'package:connection_coach/utils/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({
    Key? key,
    required this.audioFilePaths,
  }) : super(key: key);
  final List<String> audioFilePaths;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ChangeNotifierProvider(
          create: (_) => AudioManager(
            audioFilePaths: audioFilePaths,
          ),
          child: Column(
            children: [
              Playlist(),
              CurrentSongTitle(),
              AudioProgressBar(),
              AudioControlButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: Provider.of<AudioManager>(
        context,
        listen: false,
      ).currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: Provider.of<AudioManager>(
          context,
          listen: false,
        ).playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.separated(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  playlistTitles[index],
                  style: const TextStyle(),
                ),
                leading: const Icon(
                  FontAwesomeIcons.music,
                  color: Color(0xFFFECCD1),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(thickness: 2);
            },
          );
        },
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: Provider.of<AudioManager>(
        context,
        listen: false,
      ).progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          thumbColor: const Color(0xFFFECCD1),
          baseBarColor: const Color(0x33FECCD1),
          bufferedBarColor: const Color(0x66FECCD1),
          progressBarColor: const Color(0xFFFECCD1),
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: Provider.of<AudioManager>(
            context,
            listen: false,
          ).seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
        ],
      ),
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Provider.of<AudioManager>(
        context,
        listen: false,
      ).isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: (isFirst)
              ? null
              : Provider.of<AudioManager>(
                  context,
                  listen: false,
                ).onPreviousSongButtonPressed,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: Provider.of<AudioManager>(
        context,
        listen: false,
      ).playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: const CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: Provider.of<AudioManager>(
                context,
                listen: false,
              ).play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: Provider.of<AudioManager>(
                context,
                listen: false,
              ).pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Provider.of<AudioManager>(
        context,
        listen: false,
      ).isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: (isLast)
              ? null
              : Provider.of<AudioManager>(
                  context,
                  listen: false,
                ).onNextSongButtonPressed,
        );
      },
    );
  }
}
