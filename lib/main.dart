import 'package:dyte_test/join_room.dart';
import 'package:dyte_test/meeting_handler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  String roomName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              minWidth: 200,
              color: Colors.blue.shade800,
              textColor: Colors.white,
              child: const Text('Create Room'),
              onPressed: () async {
                final MeetingHandler meetingHandler = MeetingHandler.instance;
                final meet = await meetingHandler.createMeeting();
                if (meet != null) {
                  if (!mounted) {
                    return;
                  }

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => JoinRoom(
                            roomName: meet.data.meeting.roomName,
                            meetId: meet.data.meeting.id,
                          ))));
                }
              },
            ),
            MaterialButton(
              minWidth: 200,
              color: Colors.blue.shade800,
              textColor: Colors.white,
              child: const Text('Join Room'),
              onPressed: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
