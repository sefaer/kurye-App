import 'package:freezed_annotation/freezed_annotation.dart';

part 'route.freezed.dart';
part 'route.g.dart';

@freezed
class Route with _$Route {
  const factory Route({
    required int id,
    required String name,
    required List<Customer> customers,
  }) = _Route;

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
}

@freezed
class Customer with _$Customer {
  const factory Customer({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
