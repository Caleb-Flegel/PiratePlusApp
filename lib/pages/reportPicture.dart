import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pirate_plus/Classes/report.dart';
import 'package:pirate_plus/pages/GPTEmotionRepsonse.dart';

class reportPicture extends StatefulWidget {
  const reportPicture({Key? key, this.curReport, required this.camera}) : super(key: key);

  final CameraDescription camera;
  final report? curReport;

  @override
  State<reportPicture> createState() => _reportPictureState();
}

class _reportPictureState extends State<reportPicture> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  // List<CameraDescription>? cameras;
  // CameraController? camControl;
  // XFile? image;

  @override
  void initState() {
    super.initState();
  }

  loadCamera() async {
    _controller = CameraController(
        widget.camera,
        ResolutionPreset.medium
    );
    _initializeControllerFuture = _controller.initialize();

    // cameras = await availableCameras();
    // if (cameras != null) {
    //   camControl = CameraController(cameras![0], ResolutionPreset.max);
    //
    //   camControl!.initialize().then((_) {
    //     if (!mounted) {
    //       return;
    //     }
    //     setState(() {});
    //   });
    // } else {
    //   print("No cam found!");
    // }
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pirate Plus"),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
              Color.fromARGB(255, 106, 229, 198),
              Colors.cyan.shade700
            ]))),
        elevation: 0,
        actions: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("User"),
                Text(" Name"),
              ]),
          IconButton(
            onPressed: () {
              print("Go edit user settings");
            },
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Take a picture!',
                style: TextStyle(
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '(If you\'d like)',
                style: TextStyle(fontSize: 18.0),
              ),
              Container(
                  height: 300,
                  width: 400,
                  child: FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CameraPreview(_controller);

                      } else {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    },
                  )
              ),
              ElevatedButton.icon(
                  onPressed: () async{
                    try {
                      await _initializeControllerFuture;
                      final image = _controller.takePicture();

                      if(!mounted) return;

                      // If the picture was taken, display it on a new screen.
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(
                            // Pass the automatically generated path to
                            // the DisplayPictureScreen widget.
                            image: image as XFile,
                          ),
                        ),
                      );

                    } catch (e) {
                      print(e);
                    }
                  },
                  label: Text("Capture a picture!"),
                icon: Icon(Icons.camera_alt_outlined),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[700],
                ),
                onPressed: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return gptResponse(curReport: widget.curReport,);
                  }));
                },
                child: Text(
                  "Next ->",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final XFile image;

  const DisplayPictureScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(image.path)),
    );
  }
}