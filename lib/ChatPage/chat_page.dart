import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:jungwon/ChatPage/widgets/messages.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

import '../models/chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  bool available = false;
  List<Chat> chatList = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    available = await _speech.initialize(
      onStatus: (val) => {
        if (val == 'done')
          {
            setState(() {
              _isListening = false;
                chatList.add(Chat(DateTime.now(), _text, 'me'));
            }),
            getAnswer(_text)
          }
        else
          print('onStatus: $val')
      },
      onError: (val) => print('onError: $val'),
    );
    setState(() {});
  }

  void getAnswer(String input) async {
    String uri = 'http://10.0.2.2:5000/chat/askGPT';
    http.Response response = await http.post(Uri.parse(uri),
        headers: <String, String>{'Content-Type': "application/json"},
        body: jsonEncode(<String, String>{'text': input}));
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    chatList.add(Chat(DateTime.now(), responseMap['result'], 'GPT'));
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _isListening = false;
                _text = 'Press the button and start speaking';
              });
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 85.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(
            _isListening ? Icons.mic : Icons.mic_none,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
        child: Column(children: [
          Text(
            _text,
            style: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Messages(
              chatList: chatList,
            ),
          ),
        ]),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
