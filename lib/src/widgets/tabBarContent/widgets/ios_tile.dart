import 'package:flutter/material.dart';

class IosTile extends StatelessWidget {
  const IosTile({Key key, @required this.post}) : super(key: key);

  final dynamic post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey))),
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
          Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 15.0)
        ],
      ),
    );
  }
}
