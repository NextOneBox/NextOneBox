import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../OtherFiles/history.dart';
import '../OtherFiles/widgets.dart';
import 'home.dart';
import 'model.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

// const backgroundColor = Color(0xff343541);
const backgroundColor = Color.fromARGB(255, 255, 255, 255);
// const botBackgroundColor = Color(0xff444654);
const botBackgroundColor = Color.fromARGB(255, 255, 255, 255);

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

Future<String> generateResponse(String prompt) async {
  var apiKey = apikey!.get(0).toString();

  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $apiKey"
    },
    body: json.encode({
      "model": "text-davinci-003",
      "prompt": prompt,
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );

  // Do something with the response
  Map<String, dynamic> newresponse = jsonDecode(response.body);

  return newresponse['choices'][0]['text'];
}

BannerAd? _ad;
bool adLoaded = false;

class _VoiceScreenState extends State<VoiceScreen> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    isLoading = false;
    BannerAd(
      adUnitId: 'ca-app-pub-5816602993651380/9025974949',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
            //             DateTime now = DateTime.now();
            // final formattedDate = "${now.year}${now.month}${now.day}";
            //           if (int.parse(ChatAiPrem) < int.parse(formattedDate)) {
            adLoaded = true;
            // }
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    print('working');
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  speeknow(String value) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(value);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      if (result.finalResult == true) {
        setState(
          () {
            history.add(_lastWords);
            _messages.add(
              ChatMessage(
                text: _lastWords,
                chatMessageType: ChatMessageType.user,
              ),
            );
            isLoading = true;
          },
        );
        var input = _lastWords;
        _textController.clear();
        Future.delayed(const Duration(milliseconds: 10))
            .then((_) => _scrollDown());
        generateResponse(input).then((value) {
          setState(() {
            speeknow(value);
            history.add(value);

            isLoading = false;
            _messages.add(
              ChatMessage(
                text: value,
                chatMessageType: ChatMessageType.bot,
              ),
            );
          });
        });
        _textController.clear();
        Future.delayed(const Duration(milliseconds: 10))
            .then((_) => _scrollDown());
      }
    });
  }

//how to disable popup on notifcation in flutter

  FlutterTts flutterTts = FlutterTts();
// how to add music control on notification bar in flutter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        actions: <Widget>[
          // Adding button on AppBar
          IconButton(
              icon: Icon(
                Icons.history,
                color: MainColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
              })
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: MainColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavigation()),
              );
            }),
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Talk with AI",
            style: TextStyle(color: MainColor),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: botBackgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/weqr.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              adLoaded
                  ? Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: AdWidget(ad: _ad!),
                    )
                  : const SizedBox(),
              Expanded(
                child: _buildList(),
              ),
              Visibility(
                visible: isLoading,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        'While generating this answer you can ask more',
                        style: TextStyle(
                            fontSize: 10, backgroundColor: Colors.white),
                      )),
                      CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    if (coins == 0) {
                      {
                        showMessage(context,
                            'You have no coins to make request. Please make coins in home page.');
                      }
                    } else {
                      _speechToText.isNotListening
                          ? _startListening
                          : _stopListening();
                    }
                  },
                  tooltip: 'Listen',
                  child: Icon(
                    _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.black),
        controller: _textController,
        decoration: InputDecoration(
          fillColor: Colors.white38,
          filled: true,
          //how to geive focus border color  in textfield
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 2.0),
          ),
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),

        padding: const EdgeInsets.only(left: 5, right: 0, top: 5, bottom: 5),
        // color: chatMessageType == ChatMessageType.bot
        //     ? botBackgroundColor
        //     : backgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  chatMessageType == ChatMessageType.bot
                      ? Container(
                          // margin: const EdgeInsets.only(right: 16.0),
                          child: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              FontAwesomeIcons.robot,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(
                          // margin: const EdgeInsets.only(right: 16.0),
                          child: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              FontAwesomeIcons.solidCircleUser,
                              color: Colors.black,
                            ),
                          ),
                        ),
                  IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(text)
                            .then((value) => {showMessage(context, 'Copied')});
                      },
                      icon: Icon(Icons.copy)),
                  IconButton(
                      onPressed: () async {
                        await flutterTts.setLanguage('en-US');
                        await flutterTts.setPitch(1);
                        await flutterTts.speak(text);
                      },
                      icon: Icon(Icons.spatial_audio_off_outlined)),
                  IconButton(
                      onPressed: () async {
                        await flutterTts.pause();
                      },
                      icon: Icon(Icons.pause))
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Text(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: MainColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
