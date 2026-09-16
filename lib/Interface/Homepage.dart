import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Controller/DataController.dart';
import '../Controller/StateController.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final StateController _stateController = StateController();//for data from provider
  late List<Product> _items = [];
  final DataController _dataController = DataController();//for data from CDN provided
  late bool _isloading;

  @override
  void initState() {
    super.initState();
    _stateController.updateLimit(20);
    _stateController.updateSkip(0);
    _isloading = _stateController.isLoading;
    _dataController.getProduct(_stateController.limit, _stateController.skip).then((_) {
      setState(() {
        _items = _dataController.items;
        _stateController.updateLoadingStatus(false);
        _isloading = _stateController.isLoading;
      });
    });
  }

  @override
  void dispose() {
    _stateController.updateSkip(0);
    _stateController.updateLimit(0);
    _stateController.updateLoadingStatus(true);
    _items.clear();
    super.dispose();
  }

  Future<void> onRefresh() async {
    setState(() {
      _stateController.updateLoadingStatus(true);
      _isloading = _stateController.isLoading;
      _items.clear();
    });
    _stateController.updateLimit(10);
    _stateController.updateSkip(0);
    await _dataController.getProduct(_stateController.limit, _stateController.skip).then((_) {
      setState(() {
        _items = _dataController.items;
        _stateController.updateLoadingStatus(false);
        _isloading = _stateController.isLoading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Neurogine Catalog'),
      ),
      body:
      RefreshIndicator(
          onRefresh: onRefresh,
          child: Column(
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
              Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                child: Skeletonizer(
                  enabled: _isloading,
                    child: (_items.isEmpty && !_isloading)
                        ? const Center(child: Text('No Item Provided'))
                        : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: _isloading ? 6 : _items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final produce = _isloading
                            ? Product(
                          id: 0,
                          title: 'Loading Item',
                          description: '...',
                          price: 00.00,
                          thumbnail: '',
                        )
                            : _items[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    produce.thumbnail,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) =>
                                    const SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Icon(Icons.broken_image, color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        produce.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        produce.description,
                                        style: const TextStyle(
                                          fontSize: 8,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'RM ${produce.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },

                    )
                )

              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05, width: double.infinity,
                color: Colors.blue,
                child: Center(child: Text('Copyright of Neurogine Assessment'),),
              ),
            ],
          )
      )

    );
  }
}
