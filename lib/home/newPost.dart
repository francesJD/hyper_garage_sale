import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hyper_garage_sale/models/user.dart';
import 'package:hyper_garage_sale/services/database.dart';
import 'package:hyper_garage_sale/sources/customerContainer.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _formKey = GlobalKey<FormState>();

  late String _currentTitle;
  late int _currentPrice;
  late String _currentDescription;
  List<String> _imageUrls = <String>[]; //TODO: check if correct
  List<Asset> _images = <Asset>[]; //TODO: check if correct
  bool loading = false;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _titleField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Title',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (val) => val!.isEmpty ? 'Title cannot be empty' : null,
            onChanged: (val) {
              setState(() => _currentTitle = val);
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _priceField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (val) => val!.isEmpty ? 'Price cannot be empty' : null,
            // (val is int) ? 'Price must be an integer' : null,
            onChanged: (val) {
              setState(() => _currentPrice = int.parse(val));
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _descriptionField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (val) =>
                val!.isEmpty ? 'Description cannot be empty' : null,
            onChanged: (val) {
              setState(() => _currentDescription = val);
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return _images.length == 0
        ? SizedBox(
            height: 20.0,
          )
        : Container(
            child: SizedBox(
              height: 130,
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: List.generate(_images.length, (index) {
                  Asset asset = _images[index];
                  return AssetThumb(
                    asset: asset,
                    width: 150,
                    height: 150,
                  );
                }),
              ),
            ),
          );
  }

  Widget _customButton(String hint) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.orange, Colors.deepOrange])),
      child: Text(
        hint,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  void _postNewItemSnackBar(BuildContext context) {
    print('postNewItemSnackbar');
    final snackBar = SnackBar(
      content: new Text(
          "Added new post successfully! You can return to home page to check it now."),
      duration: Duration(minutes: 2),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<void> _getImageList() async {
    try {
      var resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
      );
      setState(() {
        _images = resultList;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future _postImage(Asset imageFile) async {
    // print('postImage');
    // ByteData byteData = await imageFile.getByteData();
    // List<int> imageData = byteData.buffer.asUint8List();
    // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    // Reference reference = FirebaseStorage.instance.ref().child(fileName);
    // UploadTask uploadTask =
    //     reference.putData(imageData); //TODO: 1.continue to modify this
    // TaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    // String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    //
    // _imageUrls.add(imageUrl.toString());
  }


  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 80),
                            _titleField(),
                            _priceField(),
                            _descriptionField(),
                            _buildGridView(),
                            RaisedButton(
                              color: Colors.white,
                              elevation: 0.0,
                              child: _customButton('Select Photos'),
                              onPressed: () {
                                _getImageList();
                              },
                            ),
                            SizedBox(height: 20),
                            RaisedButton(
                              color: Colors.white,
                              elevation: 0.0,
                              child: _customButton('Post'),
                              onPressed: () async {
                                print('post successfully1');
                                if (_formKey.currentState!.validate()) {
                                  //add a snack bar to show user add new post successfully
                                  _postNewItemSnackBar(context);
                                  print('post successfully2');
                                  for (Asset a in _images) {
                                    await _postImage(a);
                                  }
                                  await DatabaseService(uid: user.uid)
                                      .updateUserData(
                                          _currentTitle,
                                          _currentPrice,
                                          _currentDescription,
                                          _imageUrls);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
                Positioned(
                    top: -MediaQuery.of(context).size.height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: CustomContainer())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
