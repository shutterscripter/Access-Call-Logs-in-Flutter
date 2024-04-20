import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';

class CallLogScreen extends StatefulWidget {
  const CallLogScreen({super.key});

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Call Logs',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchRecords(),
          builder: (BuildContext context,
              AsyncSnapshot<Iterable<CallLogEntry>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching call logs'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    CallLogEntry entry = snapshot.data!.elementAt(index);
                    //calculate the duration of the call in minutes and seconds
                    var duration = Duration(seconds: entry.duration!);
                    return Card(
                      shadowColor: Colors.white,
                      margin: const EdgeInsets.all(5.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 2.0,
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          entry.number.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.deepPurple,
                          ),
                        ),
                        subtitle: Text(
                          entry.callType.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Text(
                          '${duration.inMinutes} min ${duration.inSeconds.remainder(60)} sec',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }

  Future<Iterable<CallLogEntry>> fetchRecords() async {
    /// getting all call logs
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries;
  }
}
