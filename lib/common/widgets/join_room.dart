import 'package:flutter/material.dart';
import 'package:project_reunite/Apis/webrtc.dart';

import 'package:project_reunite/common/common.dart';
import 'package:project_reunite/common/get_it.dart';

showEnterRoomIDDialog(
  BuildContext context,
 ) async {
  String? roomID;

  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: const Text("Enter room ID"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Enter your best friend room Id"),
                TextFormField(onChanged: (value) {
                  roomID = value;
                }),
                const SizedBox(
                  height: 30,
                ),
                ButtonUI(
                  onpressed: () async {
                    await getIt<Signalling>().joinRoom(roomID!);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, roomID);
                  },
                  text: "join",
                )
              ],
            ),
          ));
}
