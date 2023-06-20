
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ButtonUI extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  final double? wsize;
  final double? hsize;
  final double? fontsize =20;
  const ButtonUI({
    Key? key,
    required this.onpressed,
    required this.text,
    this.wsize, this.hsize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Container(
                  width: wsize,
                  height: hsize,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5)
                ]),
              ),
            )),
            TextButton(
              onPressed: onpressed,
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: fontsize)),
              child: Text(text),
            )
          ],
        ),
      ),
    );
  }
}



/// copy button 
class CopyButton extends StatelessWidget {
  final String text;

  const CopyButton({super.key, required this.text});

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _copyToClipboard(context),
     icon: const Icon(Icons.copy_outlined),
    );
  }
}

Widget circularButton ( VoidCallback callback, Color color , Widget icon ) {
  
  return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Container(
                  width: 25,
                  height: 25,
              decoration:  BoxDecoration(
                color: color
              ),
            )),
            IconButton(onPressed: callback, icon: icon)
            
          ],
        ),
      ),
    );
}
