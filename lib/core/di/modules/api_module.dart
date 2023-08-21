import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiModule{

  @lazySingleton
  Dio get dio=> Dio();
}