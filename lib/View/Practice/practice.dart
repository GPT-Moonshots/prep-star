import 'dart:io';

import 'package:flutter/material.dart';
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
            const Card(
              child: Text('Chat with AI'),
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
