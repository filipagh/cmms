import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';

Expanded buildRedmineComments(RedmineIssueDataSchema redmineData) {
  return Expanded(
    child: ListView.builder(
      itemCount: redmineData.comments.length ?? 0,
      itemBuilder: (context, index) {
        var comment = redmineData.comments[index];
        return ListTile(
          title: Text(comment.author + ": " + comment.comment),
          subtitle: Text("napisal v case: " +
              comment.createdOn.toString().substring(0, 19)),
        );
      },
    ),
  );
}
