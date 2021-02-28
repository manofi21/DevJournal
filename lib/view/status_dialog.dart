import 'package:flutter/material.dart';
import 'package:DevJournal/view/home_page.dart';

void showDialogClass([Map<String, dynamic> status]) {
  showDialog(
    context: scaffoldKey.currentContext,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => StatusDialog(status),
  );
}

class StatusDialog extends StatelessWidget {
  final Map<String, dynamic> status;
  StatusDialog([this.status]);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: status == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status : ${status.keys.first}'),
                Text('Message : ${status.values.first}'),
                Center(
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK")),
                )
              ],
            ),
    );
  }
}
