import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:pirate_plus/Classes/report.dart';
import 'package:pirate_plus/pages/GPTEmotionRepsonse.dart';

class reportPicture extends StatefulWidget {
  const reportPicture({Key? key, this.curReport}) : super(key: key);

  final report? curReport;

  @override
  State<reportPicture> createState() => _reportPictureState();
}

class _reportPictureState extends State<reportPicture> {
  List<CameraDescription>? cameras;
  CameraController? camControl;
  XFile? image;

  @override
  void initState() {
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      camControl = CameraController(cameras![0], ResolutionPreset.max);

      camControl!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("No cam found!");
    }
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
                  child: camControl == null
                      ? Center(
                          child: Text("Loading Camera"),
                        )
                      : CameraPreview(camControl!)
              ),
              ElevatedButton.icon(
                  onPressed: () async{
                    try {
                      if (camControl != null) {
                        if (camControl!.value.isInitialized) {
                          image = await camControl!.takePicture();
                          setSate() {

                          }
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  label: Text("Capture a picture!"),
                icon: Icon(Icons.camera),
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
