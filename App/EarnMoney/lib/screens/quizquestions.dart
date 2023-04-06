import '../otherfiles/widgets.dart';

enum SingingCharacter { one, two, three, four }

class QuizQuesions extends StatefulWidget {
  const QuizQuesions({
    super.key,
    required,
    this.topic,
  });
  final topic;

  @override
  State<QuizQuesions> createState() => _QuizQuesionsState();
}

int currentindex = 0;
int itemcount = 1;

class _QuizQuesionsState extends State<QuizQuesions> {
  var _isTapped = true;
  var _isTappedone = false;
  SingingCharacter? _character = SingingCharacter.one;
  @override
  Widget build(BuildContext context) {
    dynamic lisitem = quiz?.values
        .toList()
        .where((tet) => tet['topic'] == widget.topic)
        .toList();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          elevation: 0,
          title: Text(
            widget.topic,
            style: TextStyle(
                color: PrColor, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        body: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
          onclicknext() {
            setState(() {
              if (lisitem.length > currentindex) {
                currentindex = 1;
                itemcount = 2;
              } else {
                currentindex = 0;
                itemcount = 2;
              }
            });
          }

          return ListView.builder(
              itemCount: itemcount,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      width: 500,
                      height: 150,
                      decoration: UseBorder,
                      child: Center(
                          child: Text(lisitem[currentindex]['question'])),
                    ),
                    RadioListTile<SingingCharacter>(
                      title: Text(lisitem[currentindex]['one']),
                      value: SingingCharacter.one,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    RadioListTile<SingingCharacter>(
                      title: Text(lisitem[currentindex]['two']),
                      value: SingingCharacter.two,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    RadioListTile<SingingCharacter>(
                      title: Text(lisitem[currentindex]['three']),
                      value: SingingCharacter.three,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    RadioListTile<SingingCharacter>(
                      title: Text(lisitem[currentindex]['four']),
                      value: SingingCharacter.four,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    Container(
                      width: 250,
                      height: 45,
                      margin: EdgeInsets.fromLTRB(20, 50, 20, 2),
                      child: GFButton(
                        fullWidthButton: true,
                        shape: GFButtonShape.pills,
                        size: GFSize.LARGE,
                        color: Colors.black,
                        child: Text(
                          'Next',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'RobotoMono'),
                        ),
                        onPressed: () {
                          setState(() {
                            if (lisitem.length > currentindex) {
                              currentindex = 1;
                              itemcount = 2;
                            } else {
                              currentindex = 0;
                              itemcount = 2;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                );
              });
        }));
  }
}
