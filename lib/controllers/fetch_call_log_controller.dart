import 'package:call_log/call_log.dart';

class FetchCallLogController {
  Future<Iterable<CallLogEntry>> fetchRecords() async {
    /// getting all call logs
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries;
  }
}