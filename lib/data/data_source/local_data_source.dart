import 'dart:developer';

import 'package:tut/data/network/error_handler.dart';

import '../response/responses.dart';

const String cacheKey = "Cache Key";
const int cacheInterval = 60 * 1000;

abstract class LocalDataSource {
  HomeResponse getHomeData();
  Future<void> setHomeData(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CacheItem> cacheMap = {};
  @override
  HomeResponse getHomeData() {
    CacheItem? cacheItem = cacheMap[cacheKey];

    if (cacheItem != null && cacheItem.isValid(cacheInterval)) {
      log("cache item is valid");
      return cacheItem.data;
    } else {
      log("cache item is not valid");
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> setHomeData(HomeResponse homeResponse) async {
    cacheMap[cacheKey] = CacheItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CacheItem {
  dynamic data;
  CacheItem(this.data);

  int cacheTime = DateTime.now().millisecondsSinceEpoch;
}

extension CacheItemExtension on CacheItem {
  bool isValid(int expirationTime) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTime - cacheTime < expirationTime;
    return isValid;
  }
}
