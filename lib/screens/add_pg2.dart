import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageTextForm extends StatefulWidget {
  @override
  _ImageTextFormState createState() => _ImageTextFormState();
}

class _ImageTextFormState extends State<ImageTextForm> {
  final _textInputController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image and Text Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 16.0),
            if (_selectedImage != null) ...[
              SizedBox(height: 100, child: Image.file(_selectedImage!)),
              SizedBox(height: 16.0),
            ],
            TextField(
              controller: _textInputController,
              decoration: InputDecoration(
                labelText: 'Text',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final text = _textInputController.text.trim();
                if (_selectedImage != null && text.isNotEmpty) {
                  // Perform the necessary actions with the selected image and text
                  // For example, upload the image and text to Supabase or process them further
                  print('Selected Image: ${_selectedImage!.path}');
                  print('Text: $text');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Please select an image and enter text.')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
