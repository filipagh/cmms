# BackendAPI.model.AssignedComponentSchema

## Load the model package
```dart
import 'package:BackendAPI/api.dart';
```

## Properties

 Name                        | Type                                                      | Description | Notes      
-----------------------------|-----------------------------------------------------------|-------------|------------
 **assetId**                 | **String**                                                |             |
 **stationId**               | **String**                                                |             |
 **serialNumber**            | **String**                                                |             | [optional] 
 **id**                      | **String**                                                |             |
 **status**                  | [**AssignedComponentState**](AssignedComponentState.md)   |             |
 **taskId**                  | **String**                                                |             | [optional] 
 **installedAt**             | [**DateTime**](DateTime.md)                               |             |
 **removedAt**               | [**DateTime**](DateTime.md)                               |             | [optional] 
 **componentWarrantyUntil**  | [**DateTime**](DateTime.md)                               |             | [optional] 
 **componentWarrantySource** | [**ComponentWarrantySource**](ComponentWarrantySource.md) |             |
 **componentWarrantyId**     | **String**                                                |             | [optional] 
 **prepaidServiceUntil**     | [**DateTime**](DateTime.md)                               |             | [optional] 
 **serviceContractUntil**    | [**DateTime**](DateTime.md)                               |             | [optional] 
 **serviceContractId**       | **String**                                                |             | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


