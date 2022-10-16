# BackendAPI.api.StorageManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAllStorageItemsStorageManagerAllStorageDataGet**](StorageManagerApi.md#getallstorageitemsstoragemanagerallstoragedataget) | **GET** /storage-manager/all-storage-data | Get All Storage Items


# **getAllStorageItemsStorageManagerAllStorageDataGet**
> List<StorageItemSchema> getAllStorageItemsStorageManagerAllStorageDataGet()

Get All Storage Items

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = StorageManagerApi();

try {
    final result = api_instance.getAllStorageItemsStorageManagerAllStorageDataGet();
    print(result);
} catch (e) {
    print('Exception when calling StorageManagerApi->getAllStorageItemsStorageManagerAllStorageDataGet: $e\n');
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

