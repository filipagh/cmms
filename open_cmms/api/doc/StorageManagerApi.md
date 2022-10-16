# BackendAPI.api.StorageManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAssetsStorageManagerAllStorageDataGet**](StorageManagerApi.md#getassetsstoragemanagerallstoragedataget) | **GET** /storage-manager/all-storage-data | Get Assets


# **getAssetsStorageManagerAllStorageDataGet**
> List<StorageItemSchema> getAssetsStorageManagerAllStorageDataGet()

Get Assets

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = StorageManagerApi();

try {
    final result = api_instance.getAssetsStorageManagerAllStorageDataGet();
    print(result);
} catch (e) {
    print('Exception when calling StorageManagerApi->getAssetsStorageManagerAllStorageDataGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<StorageItemSchema>**](StorageItemSchema.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

