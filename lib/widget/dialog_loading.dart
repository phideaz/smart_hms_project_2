import 'package:flutter/material.dart';

class DialogLoading extends StatelessWidget {

  String title;
  DialogLoading(this.title);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
