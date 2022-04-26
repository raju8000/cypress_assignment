import 'package:cypress_task/helper/hiveDataHelper.dart';
import 'package:cypress_task/model/model_album.dart';
import 'package:cypress_task/model/model_photo.dart';
import 'package:flutter/cupertino.dart';
import 'photo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:cypress_task/network/api_call.dart';
import 'package:cypress_task/network/api_services.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(PhotoLoading());

  fetchPhotos(List<Album> modelAlbums) async {
    BaseOptions options = BaseOptions(method:'GET',baseUrl: ApiServices.BASE_URL);

    List<dynamic>? response = await HiveHelper.getPhotos();

    if(response==null) {
      response = await Future.wait([
        ApiCall.call(url: ApiServices.PHOTOS + '?albumId=' + modelAlbums[0].id.toString(), options: options)!,
        ApiCall.call(url: ApiServices.PHOTOS + '?albumId=' + modelAlbums[1].id.toString(), options: options)!,
        ApiCall.call(url: ApiServices.PHOTOS + '?albumId=' + modelAlbums[2].id.toString(), options: options)!,
        ApiCall.call(url: ApiServices.PHOTOS + '?albumId=' + modelAlbums[3].id.toString(), options: options)!,
      ]);
      HiveHelper.insertPhotos(response);
    }
    if (response != null) {
      debugPrint('Photo Response=>' + response.toString());
      Map<int,List<ModelPhoto>> photosData = {};
      for (var album in response) {
        List<ModelPhoto> modelPhotos = [];
        for(var item in album) {
          modelPhotos.add(ModelPhoto.fromJson(item));
        }
        photosData[album[0]['albumId']] = modelPhotos;
      }
      emit(PhotoFetchSuccess(photosData));
    }else {
      emit(PhotoError('Something went wrong'));
    }
  }

}