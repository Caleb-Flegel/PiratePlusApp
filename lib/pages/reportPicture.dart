import "dart:io";
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pirate_plus/Classes/report.dart';
import 'package:pirate_plus/Classes/session.dart';
import 'package:pirate_plus/pages/GPTEmotionRepsonse.dart';
import 'dart:math';

import 'Account.dart';

class reportPicture extends StatefulWidget {
  const reportPicture({Key? key, this.curSession, this.camera})
      : super(key: key);

  final CameraDescription? camera;
  final Session? curSession;

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
    print ("camera init state");
    print(widget.camera);
    if (widget.camera != null) loadCamera();
  }

  loadCamera() async {
    if (widget.camera != null) {
      print ("working on camera initialization");
      CameraDescription temp = widget.camera as CameraDescription;
      _controller = CameraController(temp, ResolutionPreset.max);
      print ("nearly done with camera initialization");
      _initializeControllerFuture = _controller.initialize();
    }
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nexus"),
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
                Text(
                    "${widget.curSession?.firstname}"
                ),
                Text(
                    " ${widget.curSession?.lastname}"
                ),
              ]),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return AccountViewer(curSession: widget.curSession,);
              })
              );
            },
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
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
                  ],
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                flex: 17,
                child: Column(
                  children: [
                    Expanded(
                      flex: 19,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              width: 2,
                              color: Colors.cyan.shade700,
                            ),
                          ),
                          child: FutureBuilder<void>(
                            future: _initializeControllerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: CameraPreview(_controller),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;
                            final image = await _controller.takePicture();

                            var imgBin = await image.readAsBytes();

                            if (!mounted) return;
                            widget.curSession?.curReport?.picture = imgBin;

                            // If the picture was taken, display it on a new screen.
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayPictureScreen(
                                  // Pass the automatically generated path to
                                  // the DisplayPictureScreen widget.
                                  curSession: widget.curSession,
                                  imgBin: imgBin,
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan[700],
                  ),
                  onPressed: () async {
                    await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return gptResponse(
                        curSession: widget.curSession,
                      );
                    }));
                  },
                  child: Text(
                    "Next ->",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
  const DisplayPictureScreen({super.key, this.imgBin, required this.curSession});

  final Session? curSession;
  final Uint8List? imgBin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nexus"),
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
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Preview:",
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 17,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      width: 2,
                      color: Colors.cyan.shade700,
                    ),
                  ),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Image.memory(imgBin!,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan[700],
                  ),
                  onPressed: () async {
                    await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return gptResponse(
                        curSession: curSession,
                      );
                    }));
                  },
                  child: Text(
                    "Next ->",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
