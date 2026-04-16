import 'dart:io';

import 'package:bloc_pattern/bloc/image_picker/image_picker_bloc.dart';
import 'package:bloc_pattern/bloc/image_picker/image_picker_event.dart';
import 'package:bloc_pattern/bloc/image_picker/image_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/sizes.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          if (state.file == null) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<ImagePickerBloc>().add(CameraCaptureEvent());
                    },
                    child: const Icon(Icons.camera),
                  ),
                  Sizes.sectionSpace,
                  InkWell(
                    onTap: () {
                      context.read<ImagePickerBloc>().add(GalleryPickerEvent());
                    },
                    child: const Icon(Icons.browse_gallery),
                  ),
                ],
              ),
            );
          } else {
            return Image.file(File(state.file!.path.toString()));
          }
        },
      ),
    );
  }
}
