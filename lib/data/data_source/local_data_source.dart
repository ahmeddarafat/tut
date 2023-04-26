import 'dart:developer';

import 'package:tut/data/network/error_handler.dart';

import '../response/responses.dart';

const String cacheHomeKey = "Cache Home Key";
const String cacheStoreDetailsKey = "Cache Store Details Key";
const int cacheInterval = 60 * 1000;

abstract class LocalDataSource {
  //* Base methods
  void clearCache();
  void removeFromCache(String key);

  //* home data
  HomeResponse getHomeData();
  void setHomeData(HomeResponse homeResponse);

  //* store details
  StoreDetailsResponse getStoreDetails();
  void setStoreDetails(StoreDetailsResponse storeDetailsResponse);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CacheItem> cacheMap = {};

  //* Base Methods
  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  //* home data
  @override
  HomeResponse getHomeData() {
    CacheItem? cacheItem = cacheMap[cacheHomeKey];
    if (cacheItem != null && cacheItem.isValid(cacheInterval)) {
      return cacheItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  void setHomeData(HomeResponse homeResponse) {
    cacheMap[cacheHomeKey] = CacheItem(homeResponse);
  }

  //* store details
  @override
  StoreDetailsResponse getStoreDetails() {
    CacheItem? cacheItem = cacheMap[cacheStoreDetailsKey];
    if (cacheItem != null && cacheItem.isValid(cacheInterval)) {
      return cacheItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  void setStoreDetails(StoreDetailsResponse storeDetailsResponse) {
    cacheMap[cacheStoreDetailsKey] = CacheItem(storeDetailsResponse);
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
