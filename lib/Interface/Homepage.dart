import 'package:flutter/material.dart';

import '../Controller/DataController.dart';
import '../Controller/StateController.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final StateController _stateController = StateController();//for data from provider
  final DataController _dataController = DataController();//for data from CDN provided

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Neurogine Catalog'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1, width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: ' Search items',
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Color(0xff0b036c),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onSubmitted: (value){
                  //to do search
                },
              ),
            ),
          ),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
