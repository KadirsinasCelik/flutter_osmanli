import 'dart:async';
import 'dart:developer';

import 'package:flutter_osmanli/notification_service.dart';

class TimerService {
  static final TimerService _instance = TimerService._internal();

  factory TimerService() => _instance;

  TimerService._internal();

  final Stopwatch _stopwatch = Stopwatch();
  final StreamController<int> _streamController =
      StreamController<int>.broadcast();
  int _elapsedMilliseconds = 0;
  Stream<int> get timerStream => _streamController.stream;

  int workDuration = 10; // 25 dakika 25 * 60
  int restDuration = 5; // 5 dakika
  bool isWorkMode = true;

  void startTimer() {
    if (!_stopwatch.isRunning) {
      log("stopwatch started");
      _stopwatch.start();
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        if (_stopwatch.isRunning) {
          log("stopwatch already started");
          _elapsedMilliseconds = _stopwatch.elapsedMilliseconds;
          _streamController.add(_elapsedMilliseconds);

          // Çalışma süresi bittiğinde
          if (isWorkMode && _stopwatch.elapsed.inSeconds >= workDuration) {
            resetTimer();
            isWorkMode = false;
            NotificationService.showNotification("Çalışma süresi tamamlandı !",
                "Çalışmanız tamamlandı,dinlenme süreniz başlıyor");
            startTimer();
          }

          // Dinlenme süresi bittiğinde
          if (!isWorkMode && _stopwatch.elapsed.inSeconds >= restDuration) {
            _stopwatch.reset();
            _elapsedMilliseconds = 0;
            _streamController.add(0);
            NotificationService.showNotification("Dinlenme süresi tamamlandı !",
                "Dinlenmeniz tamamlandı, sayaç sıfırlanıyor !");
            isWorkMode = true;
            stopTimer();
          }
        }
      });
    }
  }

  void stopTimer() {
    log("stopwatch stopped");
    _stopwatch.stop();
  }

  void resetTimer() {
    log("stopwatch resetted");
    _stopwatch.stop();
    _stopwatch.reset();
    isWorkMode = true;
    _elapsedMilliseconds = 0;
    _streamController.add(0);
  }

  int get elapsedMilliseconds => _elapsedMilliseconds;
}
