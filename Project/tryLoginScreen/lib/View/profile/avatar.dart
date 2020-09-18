import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String avatarUrl;
  final Function onTap;
  final String initals;

  const Avatar({this.avatarUrl, this.initals, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: avatarUrl == null
          ? CircleAvatar(
              radius: 40.0,
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                initals,
                style: TextStyle(fontSize: 40.0, color: Colors.orange[900]),
              ),
            )
          : CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(avatarUrl),
            ),
    );
  }
}
