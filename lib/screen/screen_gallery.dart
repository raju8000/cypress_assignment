import 'package:cypress_task/bloc/photos/photo_cubit.dart';
import 'package:cypress_task/bloc/photos/photo_state.dart';
import 'package:cypress_task/model/model_album.dart';
import '../bloc/album/album_cubit.dart';
import '../bloc/album/album_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cypress_task/screen/widgets/gallery_item_widget.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);
  static const routeName = "screenImages";

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<Album> modelAlbum = [];
  late AlbumCubit _albumCubit;

  @override
  void didChangeDependencies() {
    _albumCubit = BlocProvider.of<AlbumCubit>(context);
    _albumCubit.fetchAlbums();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext contexts) {
    Color commonColor = Colors.brown;
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'AlbumApp', style: TextStyle(color: commonColor),),
          backgroundColor: Colors.white,
        ),

        body: BlocBuilder<AlbumCubit, AlbumState>(builder: (context, state) {
          /// Loading State
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          /// Success State
          else if (state is AlbumFetchSuccess) {
            modelAlbum.addAll(state.modelAlbums.albums!);
            BlocProvider.of<PhotoCubit>(contexts).fetchPhotos(modelAlbum);

            return ListView.builder(
              shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                int albumId = modelAlbum[index%4].id!;


                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(modelAlbum[index%4].title??'Album'),

                        ///Photo Provider
                        BlocBuilder<PhotoCubit, PhotoState>(
                            builder: (context, state){
                          if (state is PhotoLoading) {
                            return const SizedBox(
                                height: 100,
                                child: Center(child: CircularProgressIndicator()));
                          } else if (state is PhotoFetchSuccess) {

                              return SizedBox(
                                height: 100,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return Container(
                                        key: UniqueKey(),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        height: size.height / 4,
                                        width: size.width / 3.2,
                                        child: GalleryItem(
                                          state.modelPhotosMap[albumId]![index % 3].thumbnailUrl ?? '',),
                                      );
                                    }),
                              );

                          }
                          else{
                            return const Center(child: Text('No Image'));
                          }
                        }),
                      ],
                    ),
                  );
                });

          }

          else {
            return  Center(child: Text((state as AlbumError).error));
          }
        }));
  }
}
