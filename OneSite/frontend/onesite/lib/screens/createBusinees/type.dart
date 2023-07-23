import 'package:flutter/material.dart';

class TypeSc extends StatefulWidget {
  @override
  _TypeScState createState() => _TypeScState();
}

class _TypeScState extends State<TypeSc> {
  List<Item> _items = generateItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slect your Business type'),
      ),
      body: ListView(
        children: _items.map<Widget>((Item item) {
          return ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: EdgeInsets.all(0),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                item.isExpanded = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return InkWell(
                    onTap: (){
                      
                    },
                    child: Card(
                      color: Colors.blue,
                      elevation: 500,
                      child: ListTile(
                        title: Text(item.headerValue),
                      ),
                    ),
                  );
                },
                body: ListTile(
                  title: Text(item.expandedValue),
                ),
                isExpanded: item.isExpanded,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  return [
    Item(
      headerValue: 'Potfolio',
      expandedValue: 'your Potfolio',
    ),
    Item(
      headerValue: 'Store',
      expandedValue: 'your store adresss',
    ),
  ];
}
void main() {
  runApp(MaterialApp(
    home: TypeSc(),
  ));
}
