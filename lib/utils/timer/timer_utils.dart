import 'dart:async';
import 'dart:developer';

class TimerUtils {
  static Timer? timer;
  static int elapsedTime = 0;

  static void start({required int startFrom, Function(int)? onTickCallback}) {
    log("timer started");
    elapsedTime = startFrom;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      elapsedTime++;
      log("elapsed time: $elapsedTime");
      if (elapsedTime % 60 == 0 && onTickCallback != null) {
        onTickCallback(elapsedTime);
      }
    });
  }

  static void stop() {
    timer?.cancel();
    timer = null;
    elapsedTime = 0;
  }

  static bool isTimerOn() {
    return timer != null && timer!.isActive;
  }

  static int secondsToRoundedMinutes(int seconds) {
    return (seconds / 60).round();
  }
}
