import 'package:cypress_task/helper/hiveDataHelper.dart';
import 'package:cypress_task/model/model_album.dart';
import 'package:cypress_task/network/api_call.dart';
import 'package:cypress_task/network/api_services.dart';
import 'package:cypress_task/bloc/album/album_state.dart';
import 'package:flutter/cupertino.dart';
import 'album_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit() : super(AlbumLoading());

  fetchAlbums() async {
    List<dynamic>? response;
    response = await HiveHelper.getAlbum();
    if(response==null) {
      BaseOptions options = BaseOptions(method: 'GET', baseUrl: ApiServices.BASE_URL);
      response = await ApiCall.call(url: ApiServices.ALBUMS, options: options);
      HiveHelper.insertAlbum(response);
    }
    if (response != null) {
      debugPrint('Responce=> '+response.toString());
      emit(AlbumFetchSuccess(ModelAlbum.fromJson(response)));
    }else {
      emit(AlbumError('Something went wrong'));
    }

  }

}