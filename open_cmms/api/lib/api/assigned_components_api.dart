//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AssignedComponentsApi {
  AssignedComponentsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Installed Component
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ComponentWarrantySource] componentsWarrantySource (required):
  ///
  /// * [DateTime] installationDate (required):
  ///
  /// * [List<AssignedComponentNewSchema>] assignedComponentNewSchema (required):
  ///
  /// * [String] componentWarrantyId:
  ///
  /// * [DateTime] componentWarrantyUntil:
  ///
  /// * [DateTime] paidServiceUntil:
  Future<Response>
      createInstalledComponentAssignedComponentsCreateInstalledComponentPostWithHttpInfo(
    ComponentWarrantySource componentsWarrantySource,
    DateTime installationDate,
    List<AssignedComponentNewSchema> assignedComponentNewSchema, {
    String? componentWarrantyId,
    DateTime? componentWarrantyUntil,
    DateTime? paidServiceUntil,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/assigned_components/create_installed_component';

    // ignore: prefer_final_locals
    Object? postBody = assignedComponentNewSchema;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams(
        '', 'components_warranty_source', componentsWarrantySource));
    queryParams.addAll(_queryParams('', 'installation_date', installationDate));
    if (componentWarrantyId != null) {
      queryParams.addAll(
          _queryParams('', 'component_warranty_id', componentWarrantyId));
    }
    if (componentWarrantyUntil != null) {
      queryParams.addAll(
          _queryParams('', 'component_warranty_until', componentWarrantyUntil));
    }
    if (paidServiceUntil != null) {
      queryParams
          .addAll(_queryParams('', 'paid_service_until', paidServiceUntil));
    }

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create Installed Component
  ///
  /// Parameters:
  ///
  /// * [ComponentWarrantySource] componentsWarrantySource (required):
  ///
  /// * [DateTime] installationDate (required):
  ///
  /// * [List<AssignedComponentNewSchema>] assignedComponentNewSchema (required):
  ///
  /// * [String] componentWarrantyId:
  ///
  /// * [DateTime] componentWarrantyUntil:
  ///
  /// * [DateTime] paidServiceUntil:
  Future<List<String>?>
      createInstalledComponentAssignedComponentsCreateInstalledComponentPost(
    ComponentWarrantySource componentsWarrantySource,
    DateTime installationDate,
    List<AssignedComponentNewSchema> assignedComponentNewSchema, {
    String? componentWarrantyId,
    DateTime? componentWarrantyUntil,
    DateTime? paidServiceUntil,
  }) async {
    final response =
        await createInstalledComponentAssignedComponentsCreateInstalledComponentPostWithHttpInfo(
      componentsWarrantySource,
      installationDate,
      assignedComponentNewSchema,
      componentWarrantyId: componentWarrantyId,
      componentWarrantyUntil: componentWarrantyUntil,
      paidServiceUntil: paidServiceUntil,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<String>')
              as List)
          .cast<String>()
          .toList();
    }
    return null;
  }

  /// Get All
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] stationId:
  Future<Response> getAllAssignedComponentsComponentsGetWithHttpInfo({ String? stationId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/assigned_components/components';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (stationId != null) {
      queryParams.addAll(_queryParams('', 'station_id', stationId));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get All
  ///
  /// Parameters:
  ///
  /// * [String] stationId:
  Future<List<AssignedComponentSchema>?> getAllAssignedComponentsComponentsGet({ String? stationId, }) async {
    final response = await getAllAssignedComponentsComponentsGetWithHttpInfo( stationId: stationId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AssignedComponentSchema>') as List)
        .cast<AssignedComponentSchema>()
        .toList();
    }
    return null;
  }

  /// Get Replacment Warranty
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] componentId:
  Future<Response>
      getReplacmentWarrantyAssignedComponentsReplacmentWarranryGetWithHttpInfo({
    String? componentId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/assigned_components/replacment_warranry';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (componentId != null) {
      queryParams.addAll(_queryParams('', 'component_id', componentId));
    }

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Replacment Warranty
  ///
  /// Parameters:
  ///
  /// * [String] componentId:
  Future<ComponentWarranty?>
      getReplacmentWarrantyAssignedComponentsReplacmentWarranryGet({
    String? componentId,
  }) async {
    final response =
        await getReplacmentWarrantyAssignedComponentsReplacmentWarranryGetWithHttpInfo(
      componentId: componentId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ComponentWarranty',
      ) as ComponentWarranty;
    }
    return null;
  }

  /// Override Warranty
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] componentId (required):
  ///
  /// * [ComponentWarrantySource] componentWarrantySource (required):
  ///
  /// * [String] componentWarrantyId:
  ///
  /// * [DateTime] componentWarrantyUntil:
  ///
  /// * [DateTime] paidServiceUntil:
  ///
  /// * [List<String>] serviceContractsId:
  Future<Response>
      overrideWarrantyAssignedComponentsOverrideWarrantyPostWithHttpInfo(
    String componentId,
    ComponentWarrantySource componentWarrantySource, {
    String? componentWarrantyId,
    DateTime? componentWarrantyUntil,
    DateTime? paidServiceUntil,
    List<String>? serviceContractsId,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/assigned_components/override_warranty';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'component_id', componentId));
    queryParams.addAll(
        _queryParams('', 'component_warranty_source', componentWarrantySource));
    if (componentWarrantyId != null) {
      queryParams.addAll(
          _queryParams('', 'component_warranty_id', componentWarrantyId));
    }
    if (componentWarrantyUntil != null) {
      queryParams.addAll(
          _queryParams('', 'component_warranty_until', componentWarrantyUntil));
    }
    if (paidServiceUntil != null) {
      queryParams
          .addAll(_queryParams('', 'paid_service_until', paidServiceUntil));
    }
    if (serviceContractsId != null) {
      queryParams.addAll(
          _queryParams('multi', 'service_contracts_id', serviceContractsId));
    }

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Override Warranty
  ///
  /// Parameters:
  ///
  /// * [String] componentId (required):
  ///
  /// * [ComponentWarrantySource] componentWarrantySource (required):
  ///
  /// * [String] componentWarrantyId:
  ///
  /// * [DateTime] componentWarrantyUntil:
  ///
  /// * [DateTime] paidServiceUntil:
  ///
  /// * [List<String>] serviceContractsId:
  Future<String?> overrideWarrantyAssignedComponentsOverrideWarrantyPost(
    String componentId,
    ComponentWarrantySource componentWarrantySource, {
    String? componentWarrantyId,
    DateTime? componentWarrantyUntil,
    DateTime? paidServiceUntil,
    List<String>? serviceContractsId,
  }) async {
    final response =
        await overrideWarrantyAssignedComponentsOverrideWarrantyPostWithHttpInfo(
      componentId,
      componentWarrantySource,
      componentWarrantyId: componentWarrantyId,
      componentWarrantyUntil: componentWarrantyUntil,
      paidServiceUntil: paidServiceUntil,
      serviceContractsId: serviceContractsId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'String',
      ) as String;
    }
    return null;
  }

  /// Remove Installed Component
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DateTime] uninstallDate (required):
  ///
  /// * [List<AssignedComponentIdSchema>] assignedComponentIdSchema (required):
  Future<Response>
      removeInstalledComponentAssignedComponentsRemoveInstalledComponentPostWithHttpInfo(
    DateTime uninstallDate,
    List<AssignedComponentIdSchema> assignedComponentIdSchema,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/assigned_components/remove_installed_component';

    // ignore: prefer_final_locals
    Object? postBody = assignedComponentIdSchema;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'uninstall_date', uninstallDate));

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Remove Installed Component
  ///
  /// Parameters:
  ///
  /// * [DateTime] uninstallDate (required):
  ///
  /// * [List<AssignedComponentIdSchema>] assignedComponentIdSchema (required):
  Future<List<String>?>
      removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost(
    DateTime uninstallDate,
    List<AssignedComponentIdSchema> assignedComponentIdSchema,
  ) async {
    final response =
        await removeInstalledComponentAssignedComponentsRemoveInstalledComponentPostWithHttpInfo(
      uninstallDate,
      assignedComponentIdSchema,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<String>')
              as List)
          .cast<String>()
          .toList();
    }
    return null;
  }
}
