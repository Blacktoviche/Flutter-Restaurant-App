import 'package:scoped_model/scoped_model.dart';

class Asset extends Model{
  final int id;
  final String assetName;
  final String originalName;

  Asset({this.id, this.assetName, this.originalName});

  static Asset fromJson(Map<String,dynamic> map){
    return Asset(
        id: map['id'], assetName: map['assetName'],originalName: map['originalName']
    );
  }
}