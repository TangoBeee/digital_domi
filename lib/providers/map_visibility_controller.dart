import 'package:flutter/foundation.dart';

class MapVisibilityController extends ChangeNotifier {
  bool _isMapLoading = true;

  bool get isMapLoading => _isMapLoading;

  void setMapLoading(bool isLoading) {
    _isMapLoading = isLoading;
    notifyListeners();
  }

  void showMap() {
    _isMapLoading = false;
    notifyListeners();
  }
}
