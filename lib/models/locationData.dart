class LocationData {
  double latitude; // Latitude, in degrees
  double longitude; // Longitude, in degrees
  double
      accuracy; // Estimated horizontal accuracy of this location, radial, in meters
  double altitude; // In meters above the WGS 84 reference ellipsoid
  double speed; // In meters/second
  double speedAccuracy; // In meters/second, always 0 on iOS
  double
      heading; //Heading is the horizontal direction of travel of this device, in degrees
  double time; //timestamp of the LocationData

  LocationData(
      {this.latitude,
      this.longitude,
      this.accuracy,
      this.altitude,
      this.speed,
      this.speedAccuracy,
      this.heading,
      this.time});
}
