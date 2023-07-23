import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano/piano.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterMidi = FlutterMidi();
  final String _value = 'assets/Yamaha.sf2';

  int? choice;

  @override
  void initState() {
    super.initState();
    load('assets/Yamaha.sf2');
  }

  void load(String asset) async {
    _flutterMidi.unmute();
    ByteData byte = await rootBundle.load(asset);
    _flutterMidi.prepare(sf2: byte, name: _value.replaceAll('assets/', ''));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              title: Text(
                'Piano Demo',
              ),
              centerTitle: true,
              actions: [
                /*
                DropdownButton<int?>(
                  value: choice ?? 1,
                  items: [
                    DropdownMenuItem(
                      child: Text('test'),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text('new'),
                      value: 2,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      choice = value;
                    });
                  },
                ),
                */

                IconButton(onPressed: () {
                  launch("tel:+972595619096");
                }, icon: Icon(Icons.call)),
                IconButton(onPressed: () {
                  launch("sms:+972595619096");
                }, icon: Icon(Icons.sms)),
                IconButton(onPressed: () {
                  launch('mailto:yehyaayash1999@gmail.com');
                }, icon: Icon(Icons.email)),
                IconButton(onPressed: () {
                  launch('https://www.instagram.com/yehya.a.ayash/');
                }, icon: Icon(Icons.info)),
              ]),
          body: Center(
            child: InteractivePiano(
              highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
              naturalColor: Colors.white,
              accidentalColor: Colors.black,
              keyWidth: 60,
              noteRange: NoteRange.forClefs([
                Clef.Treble, //
              ]),
              onNotePositionTapped: (position) {
                _flutterMidi.playMidiNote(midi: position.pitch);
              },
            ),
          ),
        ));
  }
}
