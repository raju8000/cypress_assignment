import 'package:cypress_task/bloc/photos/photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Routes/route_generator.dart';
import 'Screen/screen_gallery.dart';
import 'bloc/album/album_cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumCubit>(create: (context) => AlbumCubit()),
        BlocProvider<PhotoCubit>(create: (context) => PhotoCubit()),
      ],
      child: const MaterialApp(
        title: 'Cypress Task',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Gallery.routeName,

      ),
    );
  }
}

