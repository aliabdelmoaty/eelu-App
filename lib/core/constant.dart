import 'package:payment/core/utils/cache_helper.dart';

String token = CacheHelper.getData(key: 'uid') ?? '';
