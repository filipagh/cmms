# BackendAPI.api.AssetManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createNewMainCategoryAssetManagerNewCategoryPost**](AssetManagerApi.md#createnewmaincategoryassetmanagernewcategorypost) | **POST** /assetManager/newCategory | Create New Main Category


# **createNewMainCategoryAssetManagerNewCategoryPost**
> Object createNewMainCategoryAssetManagerNewCategoryPost(assetCategoryNewSchema)

Create New Main Category

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = AssetManagerApi();
final assetCategoryNewSchema = AssetCategoryNewSchema(); // AssetCategoryNewSchema | 

try {
    final result = api_instance.createNewMainCategoryAssetManagerNewCategoryPost(assetCategoryNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling AssetManagerApi->createNewMainCategoryAssetManagerNewCategoryPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **assetCategoryNewSchema** | [**AssetCategoryNewSchema**](AssetCategoryNewSchema.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

