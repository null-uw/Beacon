import 'package:flutter/material.dart';

class CurrentUser extends StatefulWidget {
  @override
  _CurrentUserState createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext ctx) {
    return Container(
        decoration: BoxDecoration(color: const Color(0xFFFFFFFF), boxShadow: [
          BoxShadow(
            color: Color(0xFFCCCCCC),
            blurRadius: 10.0,
          ),
        ]),
        padding: new EdgeInsets.all(24),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "First Last",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("email@email.com")
              ],
            ),
            Container(
              child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
  }
}
