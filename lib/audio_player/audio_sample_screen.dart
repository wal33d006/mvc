import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

class AudioPlayPage extends StatefulWidget {
  @override
  _AudioPlayPageState createState() => _AudioPlayPageState();
}

class _AudioPlayPageState extends State<AudioPlayPage> {
  AudioCache audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio player sample'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Play'),
          onPressed: () async {
            await audioCache.play('audios/song.mp3');
          },
        ),
      ),
    );
  }
}
