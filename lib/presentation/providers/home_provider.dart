import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, int>((ref) {
  return HomeNotifier();
});

class HomeNotifier extends StateNotifier<int> {
  HomeNotifier() : super(0);

  void updateCurrentTab(int currentTab) {
    state = currentTab;
  }
}
