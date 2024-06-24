import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepstar/View/Practice/Camera/camera_whatsapp.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final files = ValueNotifier(<File>[]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              child: InkWell(
                onTap: () {
                  context.goNamed("AIChat", pathParameters: {'chatID': '_'});
                },
                child: Card(
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://news.ubc.ca/wp-content/uploads/2023/08/AdobeStock_559145847.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Chat with AI',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: files.value.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.file(files.value[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          List<File>? res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WhatsappCamera(),
            ),
          );
          setState(() {});
          if (res != null) files.value = res;
        },
      ),
    );
  }
}
