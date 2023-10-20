import 'package:flutter/material.dart';

import '../screens/widget.dart';
import 'home_page.dart';

class explorepage extends StatefulWidget {
  const explorepage({super.key});

  @override
  State<explorepage> createState() => _explorepageState();
}

class _explorepageState extends State<explorepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                // You can change the color to your preference
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    FilterButton(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  '#Trending',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: c6),
                ),
              ),
              Container(
                height: 320,
                // width: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://media.giphy.com/media/Ii4Cv63yG9iYawDtKC/giphy.gif"))),
                          width: 200,
                          // height: 400,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  '#motivation',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: c6),
                ),
              ),
              Container(
                height: 320,
                // width: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://media.giphy.com/media/tqfS3mgQU28ko/giphy.gif"))),
                          width: 200,
                          // height: 400,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  '#lifestyle',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: c6),
                ),
              ),
              Container(
                height: 320,
                // width: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://media.giphy.com/media/3o72EX5QZ9N9d51dqo/giphy.gif"))),
                          width: 200,
                          // height: 400,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  '#eduction',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: c6),
                ),
              ),
              Container(
                height: 320,
                // width: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://media.giphy.com/media/4oMoIbIQrvCjm/giphy.gif"))),
                          width: 200,
                          // height: 400,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'FilterOption1',
            child: Text('Filter Option 1'),
          ),
          PopupMenuItem<String>(
            value: 'FilterOption2',
            child: Text('Filter Option 2'),
          ),
          PopupMenuItem<String>(
            value: 'FilterOption3',
            child: Text('Filter Option 3'),
          ),
          // Add more filter options as needed
        ];
      },
      child: ElevatedButton(
        onPressed: null,
        child: Text('Filter'),
      ),
      onSelected: (String value) {
        // Handle filter option selection here
        print('Selected filter option: $value');
      },
    );
  }
}
