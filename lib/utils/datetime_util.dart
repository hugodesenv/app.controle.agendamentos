class DateTimeUtil {
  static String formatTimeHHMM(
    Duration duration, {
    bool? showSeconds,
  }) {
    String h = duration.inHours.toString().padLeft(2, '0');
    String m = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    return '$h:$m';
  }
}
