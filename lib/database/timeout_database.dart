import 'package:hive/hive.dart';

class TimeoutDatabase {
  static final TimeoutDatabase _instance = TimeoutDatabase._internal();
  late Box<DateTime> _box;

  factory TimeoutDatabase() {
    return _instance;
  }

  TimeoutDatabase._internal();

  // Open a box and initialize box
  Future<void> open() async {
    _box = await Hive.openBox<DateTime>('timeout');
  }

  // Set last assessment datetime
  Future<void> setLastAssessmentDatetime(DateTime time) async {
    _box.put("datetime", time);
  }

  // Get last assessment datetime
  Future<DateTime?> getLastAssessmentDatetime() async {
    return _box.get("datetime");
  }
}
