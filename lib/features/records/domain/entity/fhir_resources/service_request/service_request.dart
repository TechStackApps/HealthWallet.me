import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_request.freezed.dart';
part 'service_request.g.dart';

@freezed
class ServiceRequest with _$ServiceRequest {
  factory ServiceRequest() = _ServiceRequest;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);
}
