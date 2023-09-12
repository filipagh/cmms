# BackendAPI.model.TaskChangeComponentsSchema

## Load the model package
```dart
import 'package:BackendAPI/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**stationId** | **String** |  | 
**name** | **String** |  | 
**description** | **String** |  | 
**id** | **String** |  | 
**state** | [**TaskState**](TaskState.md) |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**add** | [**List<AddComponentRequestSchema>**](AddComponentRequestSchema.md) |  | [default to const []]
**remove** | [**List<RemoveComponentRequestSchema>**](RemoveComponentRequestSchema.md) |  | [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


