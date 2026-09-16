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
    return const Placeholder();
  }
}
