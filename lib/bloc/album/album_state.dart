
import 'package:cypress_task/model/model_album.dart';

abstract class AlbumState {}

class AlbumLoading extends AlbumState {
  AlbumLoading();
}

class AlbumFetchSuccess extends AlbumState {
  final ModelAlbum modelAlbums ;
  bool deleteMode = false;

  AlbumFetchSuccess(this.modelAlbums, {this.deleteMode =false});
}

class AlbumError extends AlbumState {
  String error;
  AlbumError(this.error);
}