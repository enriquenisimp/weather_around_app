part of 'geo_location_cubit.dart';

enum GeoStatus {
  loading,
  noLocation,
  located,
}

class GeoLocationState extends Equatable {
  const GeoLocationState(this.geoStatus, this.position, this.failure);
  final GeoStatus geoStatus;
  final Position? position;
  final Failure? failure;
  const GeoLocationState.loading()
      : geoStatus = GeoStatus.loading,
        position = null,
        failure = null;
  const GeoLocationState.located(this.position)
      : geoStatus = GeoStatus.located,
        failure = null;
  const GeoLocationState.noLocation(this.failure)
      : geoStatus = GeoStatus.noLocation,
        position = null;

  @override
  List<Object?> get props => [geoStatus, position];
}
