import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:dyte_test/meeting_handler.dart';
import 'package:flutter/material.dart';

class JoinRoom extends StatefulWidget {
  final String? roomName;
  final String? meetId;

  const JoinRoom({
    Key? key,
    this.meetId,
    this.roomName,
  }) : super(key: key);

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final TextEditingController _controller = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    if (widget.roomName != null) {
      _controller.text = widget.roomName ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: TextField(controller: _controller),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: TextField(controller: _nameController),
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            color: Colors.blue.shade800,
            textColor: Colors.white,
            onPressed: () async {
              if (_controller.text != '' && _nameController.text != '') {
                final participatDetails = await MeetingHandler.instance
                    .addAParticipant(_nameController.text, widget.meetId!);
                if (!mounted) {
                  return;
                }
                if (participatDetails != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MeetingRoom(
                      authToken: participatDetails.data.authResponse.authToken,
                      roomName: widget.roomName!,
                    ),
                  ));
                }
              }
            },
            child: const Text('Join Room'),
          ),
        ],
      ),
    );
  }
}

class MeetingRoom extends StatefulWidget {
  const MeetingRoom({
    required this.authToken,
    required this.roomName,
    Key? key,
  }) : super(key: key);
  final String authToken;
  final String roomName;

  @override
  State<MeetingRoom> createState() => _MeetingRoomState();
}

class _MeetingRoomState extends State<MeetingRoom> {
  @override
  Widget build(BuildContext context) {
    // get the page height, width
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: <Widget>[
          SizedBox(
              width: width,
              height: height,
              child: DyteMeeting(
                roomName: widget.roomName,
                authToken: widget.authToken,
                onInit: (DyteMeetingHandler meeting) async {},
              ))
        ],
      ),
    );
  }
}
