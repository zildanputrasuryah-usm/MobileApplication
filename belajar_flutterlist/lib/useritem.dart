import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:belajar_flutterlist/userdata.dart';

class UserItem extends StatefulWidget {
  UserData userData;
  UserItem(this.userData);

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text(
              widget.userData.nama[0].toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userData.nama,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Umur:" +
                    widget.userData.umur.toString() +
                    "Email : " +
                    widget.userData.email),
              ],
            ),
          )
        ],
      ),
    );
  }
}
