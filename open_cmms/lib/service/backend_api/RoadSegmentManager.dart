
import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'oauthUtil.dart';




class RoadSegmentService extends RoadSegmentManagerApi {
  @override
  late final ApiClient apiClient;

  RoadSegmentService() {
    apiClient = getApiClient();
  }
}
