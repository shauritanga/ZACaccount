import 'package:flutter/material.dart';

class SubscriptionProvider with ChangeNotifier {
  String _activeSubscription = "weekly";
  String get activeAubscription => _activeSubscription;

  activeSubscription(String subscription) {
    _activeSubscription = subscription;
    notifyListeners();
  }
}
