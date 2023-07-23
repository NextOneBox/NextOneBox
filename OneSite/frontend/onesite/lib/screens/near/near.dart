import 'package:flutter/services.dart';
import 'package:onesite/helper.dart';
import 'package:flutter/material.dart';
import 'package:onesite/screens/near/services.dart';
import 'package:onesite/screens/near/shops.dart';




class Near extends StatefulWidget {


  const Near({Key? key,  }) : super(key: key);

  @override
  State<Near> createState() => _NearState();
}

class _NearState extends State<Near> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('loacl'),),
      body: Column(
        children: [
                         Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                               
                                
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        const TextStyle(color: MainColor),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: 'enter you demand',
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Search',
                                            style: TextStyle(
                                                fontSize: 18, color: MainColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                    
             
         
    SingleChildScrollView(
      child:   Container(
      height: 100,
      color: Colors.black,
      child: ListView.builder(
        
              scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
      
            return InkWell(
              onTap: () {
                        Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NearServices()),
                                    );
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                  
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                            'title',
                              style: const TextStyle(
                                  color: Color.fromARGB(
                                      255, 16, 16, 16),
                                  fontWeight:
                                      FontWeight.bold),
                            ),
                            Text(
                             'description',
                              style: const TextStyle(
                                color: Color.fromARGB(
                                    255, 110, 114, 116),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            );
          }),
      ),
    ),
    
    Flexible(
                      child: Container(
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                        
                              return InkWell(
                                onTap: () {
                                          Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NearShops()),
                                    );
                                },
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                              'title',
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                               'description',
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 110, 114, 116),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
    
        ],
      ),
    );
  }
}
