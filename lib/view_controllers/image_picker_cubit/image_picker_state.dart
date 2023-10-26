part of 'image_picker_cubit.dart';

enum ImageStatus {
  notPicked,
  picked,
  error,
}

class ImagePickerState extends Equatable {
  final ImageStatus imageStatus;
  final File imageFile;

  const ImagePickerState({
    required this.imageStatus,
    required this.imageFile,
  });

  factory ImagePickerState.initial() {
    return ImagePickerState(
      imageStatus: ImageStatus.notPicked,
      imageFile: File(''),
    );
  }

  @override
  String toString() {
    return 'ImagePickerState{imageStatus: $imageStatus, imageFile: $imageFile}';
  }

  @override
  List<Object> get props => [imageStatus, imageFile];

  ImagePickerState copyWith({
    ImageStatus? imageStatus,
    File? imageFile,
  }) {
    return ImagePickerState(
      imageStatus: imageStatus ?? this.imageStatus,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}
