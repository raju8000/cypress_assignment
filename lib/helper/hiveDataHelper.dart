import 'package:hive/hive.dart';

class HiveHelper{
  static Box? _albumBox;
  static const String _albumOpener = 'albumBox';
  static Box? _photoBox;
  static const String _photoOpener = 'photoBox';

  static Future<void> insertAlbum(List<dynamic>? albums) async {
    _albumBox = await Hive.openBox(_albumOpener);
    _albumBox!.put('albums',albums);
    await _albumBox!.close();
  }
  static Future<List<dynamic>?> getAlbum() async {
    _albumBox = await Hive.openBox(_albumOpener);
    var albums = _albumBox!.get('albums');
    await _albumBox!.close();
    return albums;
  }
  static Future<void> insertPhotos(List<dynamic>? photos) async {
    _photoBox = await Hive.openBox(_photoOpener);
    _photoBox!.put('photos',photos);
    await _photoBox!.close();
  }
  static Future<List<dynamic>?> getPhotos() async {
    _photoBox = await Hive.openBox(_photoOpener);
    var photos = _photoBox!.get('photos');
    await _photoBox!.close();
    return photos;
  }

}