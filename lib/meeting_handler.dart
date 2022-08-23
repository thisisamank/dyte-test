import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dyte_test/models/meeting_details.dart';
import 'package:dyte_test/models/participant_details.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

const baseUrl = 'https://api.cluster.dyte.in/v1';
const apiKey = '';
const orgId = '';

class MeetingHandler {
  MeetingHandler._();

  static final MeetingHandler instance = MeetingHandler._();

  final headers = {
    HttpHeaders.authorizationHeader: apiKey,
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  Future<MeetingDetails?> createMeeting() async {
    final response = await http.post(
        Uri.parse('$baseUrl/organizations/$orgId/meeting'),
        headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      log(response.body);
      return MeetingDetails.fromJson(response.body);
    } else {
      log(response.statusCode.toString());
      log(response.headers.toString());
      log(response.request!.url.toString());
    }
    return null;
  }

  Future<MeetingDetails?> getMeetingDetailsFromRoomName(String roomName) async {
    final response = await http.post(
        Uri.parse('$baseUrl/organizations/$orgId/meetings/$roomName'),
        headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      log(response.body);
      return MeetingDetails.fromJson(response.body);
    } else {
      log(response.statusCode.toString());
      log(response.headers.toString());
      log(response.request!.url.toString());
    }
    return null;
  }

  Future<ParticipantDetails?> addAParticipant(
      String name, String meetId) async {
    final id = const Uuid().v1();
    final payload = {
      "clientSpecificId": id,
      "userDetails": {"name": name},
      "roleName": "participant",
    };
    final response = await http.post(
      Uri.parse('$baseUrl/organizations/$orgId/meetings/$meetId/participant'),
      headers: headers,
      body: json.encode(payload),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ParticipantDetails.fromJson(response.body);
    } else {
      log(response.statusCode.toString());
      log(response.headers.toString());
      log(response.request!.url.toString());
      log(response.body);
    }
    return null;
  }
}
