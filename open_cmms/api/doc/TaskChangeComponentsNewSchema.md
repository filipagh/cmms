# BackendAPI.model.TaskChangeComponentsNewSchema

## Load the model package
```dart
import 'package:BackendAPI/api.dart';
```

## Properties
 Name                   | Type                                                                      | Description | Notes                 
------------------------|---------------------------------------------------------------------------|-------------|-----------------------
 **stationId**          | **String**                                                                |             |
 **name**               | **String**                                                                |             |
 **description**        | **String**                                                                |             |
 **warrantyPeriodDays** | **int**                                                                   |             |
 **add**                | [**List<TaskComponentAddNewSchema>**](TaskComponentAddNewSchema.md)       |             | [default to const []] 
 **remove**             | [**List<TaskComponentRemoveNewSchema>**](TaskComponentRemoveNewSchema.md) |             | [default to const []] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


