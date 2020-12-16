import 'package:flutter/material.dart';

class AndroidTile extends StatelessWidget {
  const AndroidTile({Key key, @required this.post}) : super(key: key);

  final dynamic post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      width: double.infinity,
      child: Row(
        children: [
          Icon(Icons.circle, color: Colors.blue, size: 14.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                  'make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[600], height: 1.3)),
            ),
          ),
          Icon(Icons.star, color: Colors.yellow[600], size: 18.0)
        ],
      ),
    );
  }
}
