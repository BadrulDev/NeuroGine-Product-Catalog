import 'package:flutter/foundation.dart';

class StateController with ChangeNotifier {
  bool _isLoading = false;
  int _limit = 0;
  int _skip = 0;

  bool get isLoggedIn => _isLoading;
  int get limit => _limit;
  int get skip => _skip;

  void updateLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  void updateLimit(int limit) {
    _limit = limit;
    notifyListeners();
  }

  void updateSkip(int skip) {
    _skip = skip;
    notifyListeners();
  }
}