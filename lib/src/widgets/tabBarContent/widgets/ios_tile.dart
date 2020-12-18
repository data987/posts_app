import 'package:flutter/material.dart';
import 'package:zemoga_posts/core/models/post_model.dart';

class IosTile extends StatelessWidget {
  const IosTile({Key key, @required this.post}) : super(key: key);

  final Post post;

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
          !post.read
              ? Icon(Icons.circle, color: Colors.blue, size: 14.0)
              : post.favorite
                  ? Icon(Icons.star, color: Colors.yellow[600], size: 17.0)
                  : SizedBox(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(post.body,
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
