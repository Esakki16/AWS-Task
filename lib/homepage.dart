import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? fileImage;
  String url = '';
  int i = 0;

  Future<void> _takePicture() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      fileImage = file;
    });
  }

  Widget buildPictureContainer() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: 250,
          width: 180,
          // ignore: sort_child_properties_last
          child: fileImage == null
              ? const SizedBox()
              : Image.file(File(fileImage!.path)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 62, 62, 62)),
        ),
        Positioned(
            bottom: 15,
            right: 15,
            child: IconButton(
                onPressed: _takePicture, icon: const Icon(Icons.add_a_photo)))
      ],
    );
  }

  Widget buildUploadButton() {
    return ElevatedButton(
      onPressed: () {
        print('Uploading');
      },
      // ignore: sort_child_properties_last
      child: const Text(
        'Upload Image',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
    );
  }

  Widget buildFetchButton() {
    return TextButton(
        onPressed: () async {
          print('Fetching');
        },
        child: const Text(
          'Fetch From Storage',
          style: TextStyle(color: Colors.blue),
        ));
  }

  Widget buildFetchPic() {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 250,
      width: 180,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                url.isEmpty
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-FrJUoDSdU8iPTFwYSlcqIIMABPHaXjjqwvLOin8&s.jpg'
                    : url,
                scale: 1.0),
          ),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 62, 62, 62)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('AWS Task'))),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildPictureContainer(),
              const SizedBox(
                height: 10,
              ),
              buildUploadButton(),
              buildFetchButton(),
              buildFetchPic()
            ],
          ),
        ),
      ),
    );
  }
}
