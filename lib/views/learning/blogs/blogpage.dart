import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityapp/controllers/blog_controller.dart';
import 'package:communityapp/views/learning/blogs/infoPage.dart';
import 'package:communityapp/views/learning/blogs/postPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Blog_Page extends StatefulWidget {
  const Blog_Page({super.key});

  @override
  State<Blog_Page> createState() => _Blog_PageState();
}

class _Blog_PageState extends State<Blog_Page> {
  double width = Get.width;
  double height = Get.height;
  // initalising controller
  BlogController blogController = Get.put(BlogController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: buildBlock(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(post_Page());
        },
        tooltip: 'Add Blog',
        splashColor: Colors.blue,
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(height * 0.2),
        child: Container(
          padding: EdgeInsets.only(
              top: height * 0.05, left: width * 0.03, right: width * 0.02),
          color: Color.fromRGBO(34, 51, 69, 1.0),
          width: width * 0.9,
          height: height * 0.125,
          child: Row(
            children: [
              // menu option
              SizedBox(width: width * 0.27),
              Text(
                'Blog Page',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(width: width * 0.18),
              InkWell(
                // get info about markdown
                onTap: () {
                  Get.dialog(Dialog(
                    child: InfoPage(),
                    shadowColor: Colors.grey,
                    shape: Border.all(
                      width: 1,
                      color: Color.fromRGBO(34, 51, 69, 1.0),
                    ),
                  ));
                },
                child: Icon(
                  Icons.info_outline,
                  size: 28,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }

  Widget buildBlock() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No posts yet!"));
          }
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              String content = doc['content'] ?? '';
              var timestamp = doc['timestamp'];
              String formattedTimestamp = '';

              if (timestamp != null) {
                // Format the date and time up to seconds
                DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
                formattedTimestamp = dateFormat.format(timestamp.toDate());
              }

              return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Markdown-formatted Content
                        MarkdownBody(
                          data: content,
                          selectable: true, // Allows text selection
                        ),
                        // timestamp view
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            formattedTimestamp,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          );
        });
  }
}
