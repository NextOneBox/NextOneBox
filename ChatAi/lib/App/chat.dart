import 'package:http/http.dart' as http;

import 'package:chatai/OtherFiles/widgets.dart';
import 'home.dart';
import 'model.dart';
import '../OtherFiles/widgets.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

// const backgroundColor = Color(0xff343541);
const backgroundColor = Color.fromARGB(255, 255, 255, 255);
// const botBackgroundColor = Color(0xff444654);
const botBackgroundColor = Color.fromARGB(255, 255, 255, 255);

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
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

class _ChatPageState extends State<ChatPage> {
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
    isLoading = false;

    BannerAd(
      adUnitId: 'ca-app-pub-7177495743199841/7198110692',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
            // DateTime now = DateTime.now();
            // final formattedDate = "${now.year}${now.month}${now.day}";
            // if (int.parse(ChatAiPrem) < int.parse(formattedDate)) {
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
          },
        ),
        title: Text(
          "Chat with AI",
          style: TextStyle(color: MainColor),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/wer.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
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
                    children: const [
                      Center(
                          child: Text(
                        'Please wait it take little time',
                        style: TextStyle(
                            fontSize: 10, backgroundColor: Colors.white),
                      )),
                      CircularProgressIndicator(
                        color: Color.fromARGB(255, 62, 60, 60),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      _buildInput(),
                      _buildSubmit(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 247, 234, 234),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.send_rounded,
              color: Colors.blueAccent,
            ),
            onPressed: () async {
              history.add(_textController.text);
              setState(
                () {
                  _messages.add(
                    ChatMessage(
                      text: _textController.text,
                      chatMessageType: ChatMessageType.user,
                    ),
                  );
                  isLoading = true;
                },
              );
              var input = _textController.text;
              _textController.clear();
              Future.delayed(const Duration(milliseconds: 10))
                  .then((_) => _scrollDown());
              generateResponse(input).then((value) {
                setState(() {
                  runadd();
                    unityloadad();
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
            },
          ),
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.blueAccent),
        controller: _textController,
        decoration: InputDecoration(
          fillColor: Colors.grey[100]!,
          filled: true,
          //how to geive focus border color  in textfield
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          ),
          // enabledBorder: InputBorder.none,
          // errorBorder: InputBorder.none,
          // disabledBorder: InputBorder.none,
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
      padding: const EdgeInsets.all(7),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100]!,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.only(left: 5, right: 0, top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.grey[200]!,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  chatMessageType == ChatMessageType.bot
                      ? Container(
                          child: const CircleAvatar(
                            child: Icon(
                              FontAwesomeIcons.robot,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(
                          child: const CircleAvatar(
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
                      icon: Icon(Icons.pause)),
                ],
              ),
            ),
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
    );
  }
}
