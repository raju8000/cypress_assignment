import 'package:cypress_task/model/model_photo.dart';

abstract class PhotoState {}

class PhotoLoading extends PhotoState {
  PhotoLoading();
}

class PhotoFetchSuccess extends PhotoState {
  final Map<int,List<ModelPhoto>> modelPhotosMap ;

  PhotoFetchSuccess(this.modelPhotosMap);
}

class PhotoError extends PhotoState {
  String error;
  PhotoError(this.error);
}