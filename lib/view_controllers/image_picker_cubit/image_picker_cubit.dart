import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerState.initial());

  Future<void> pickImage() async {
    if (state.imageStatus == ImageStatus.error) {
      emit(state.copyWith(imageStatus: ImageStatus.notPicked));
    }
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );
      if (image == null) {
        if (state.imageStatus != ImageStatus.picked) {
          emit(
            state.copyWith(
              imageStatus: ImageStatus.notPicked,
            ),
          );
        }

        return;
      } else {
        var imageFile = File(image.path);
        emit(
          state.copyWith(
            imageStatus: ImageStatus.picked,
            imageFile: imageFile,
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          imageStatus: ImageStatus.error,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
