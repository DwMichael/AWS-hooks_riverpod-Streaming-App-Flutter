import 'package:flutter_riverpod/flutter_riverpod.dart';

final downloadProgressProvider =
    StateNotifierProvider<DownloadProgress, double>(
        (ref) => DownloadProgress());

class DownloadProgress extends StateNotifier<double> {
  DownloadProgress() : super(0);

  void updateProgress(double progress) {
    state = progress;
  }
}
