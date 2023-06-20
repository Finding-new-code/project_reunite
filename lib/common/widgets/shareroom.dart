import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_reunite/constants/export.dart';
import 'package:share_plus/share_plus.dart';
import 'button.dart';

void showShareRoomidDialog(BuildContext context, String roomid) async {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text(
          "share this roomid to your friends to join them in your room bro"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("shared it bro"),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 123, 183, 233),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    roomid,style: GoogleFonts.robotoSlab(letterSpacing: 1,fontWeight: FontWeight.bold,),
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: roomid));
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Copy ot the Clipboard')));
                      },
                      icon: const Icon(Icons.copy))
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonUI(
              onpressed: () async {
                Share.share(roomid);
              },
              text: 'share')
        ],
      ),
    ),
  );
}
