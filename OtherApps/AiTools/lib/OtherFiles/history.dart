import '../App/home.dart';
import 'widgets.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();
    List hist = history.values.toList().reversed.toList();
    return Scaffold(
      appBar: AppBar(
//how to give button on appbar
        actions: <Widget>[
          // Adding button on AppBar
          IconButton(
              icon: Icon(
                Icons.delete_forever_rounded,
                color: MainColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          'Are you sure do you want to Clear your history'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Clear'),
                          onPressed: () {
                            history.clear();
                            setState(() {});
                          },
                        ),
                      ],
                    );
                  },
                );
              })
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: MainColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "History",
            style: TextStyle(color: MainColor),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: botBackgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/weq.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: history.values.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),

                padding:
                    const EdgeInsets.only(left: 5, right: 0, top: 5, bottom: 5),
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
                          index.isEven == index.isOdd
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
                                FlutterClipboard.copy('${hist[index]}').then(
                                    (value) =>
                                        {showMessage(context, 'Copied')});
                              },
                              icon: Icon(Icons.copy)),
                          IconButton(
                              onPressed: () async {
                                await flutterTts.setLanguage('en-US');
                                await flutterTts.setPitch(1);
                                await flutterTts.speak(hist[index]);
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Text(
                              '${hist[index]}',
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

            //  Padding(
            //   padding: const EdgeInsets.only(left: 30, right: 30),
            //   child: Text(
            //     "${hist[index]} \n ",
            //     style: texSty,
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
