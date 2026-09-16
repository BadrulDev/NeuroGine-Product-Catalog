import 'package:flutter/foundation.dart';

class StateController with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoggedIn => _isLoading;

  void updateLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }
}