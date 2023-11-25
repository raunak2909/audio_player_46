import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AudioPlayer? _player;
  Duration? totalDuration = Duration.zero;
  Duration currDuration = Duration.zero;
  Duration bufferDuration = Duration.zero;


  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    setUpMyPlayer();
  }

  void setUpMyPlayer() async{

    var audioUrl = "https://raag.fm/files/mp3/128/Hindi-Singles/23303/Kesariya%20(Brahmastra)%20-%20(Raag.Fm).mp3";
    totalDuration = await _player!.setUrl(audioUrl);
    _player!.play();
    _player!.processingStateStream.listen((event) {

    });
    _player!.positionStream.listen((event) {
      currDuration = event;
      setState(() {

      });
    });

    _player!.bufferedPositionStream.listen((event) {
      bufferDuration = event;
      setState(() {

      });
    });



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio'),
      ),
      body: _player!=null ? Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ProgressBar(
                  progress: currDuration,
                  buffered: bufferDuration,
                  timeLabelLocation: TimeLabelLocation.below,
                  onSeek: (newSeekValue){
                    _player!.seek(newSeekValue);
                    setState(() {

                    });
                  },
                  thumbColor: Colors.amber,
                  thumbGlowColor: Colors.amber.withOpacity(0.2),
                  bufferedBarColor: Colors.white,
                  baseBarColor: Colors.grey,
                  progressBarColor: Colors.amber,
                  total: totalDuration!),

              IconButton(onPressed: (){
                if(_player!.playing){
                  _player!.pause();
                } else {
                  _player!.play();
                }
                setState(() {

                });
              }, icon: Icon(_player!.playing ? Icons.pause : Icons.play_arrow))
            ],
          ),
        ),
      ) : Container(),
    );
  }
}
