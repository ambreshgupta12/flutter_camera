import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingScreen(),
    );
  }
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Future<File> _imageFile;

  double opacity = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _imageFile = null;
  }

  @override
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Make a choice'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      setState(() {
                        _imageFile = _openGallery(context);
                      });
                      Navigator.of(context).pop();
                    },
                    title: Text('Gallery'),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _imageFile = _openCamera(context);
                      });
                      Navigator.of(context).pop();
                    },
                    title: Text('Camera'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<File> _openGallery(BuildContext context) {
    return ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<File> _openCamera(BuildContext context) {
    return ImagePicker.pickImage(source: ImageSource.camera);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Main Screen'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

              FutureBuilder<File>(
                future: _imageFile,
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                  if (snapshot.data != null) {
                    if (snapshot.hasError) {
                      return Text('TTT');
                    } else if (snapshot.hasData) {
                      return Image.file(snapshot.data,width: 400,height: 400,);
                    } else {
                      return CircularProgressIndicator();
                    }
                  } else {
                    return SizedBox(height: 2,);
                  }
                },
              ),
              RaisedButton(
                onPressed: () =>_showChoiceDialog(context),
                child: Text('Select Iamge'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
