class Neighborhood {
  final String name;
  final String area;
  final double? latitude;
  final double? longitude;

  const Neighborhood({
    required this.name,
    required this.area,
    this.latitude,
    this.longitude,
  });

  static const List<Neighborhood> nairobiNeighborhoods = [
    Neighborhood(name: 'Karen, Nairobi', area: 'Karen', latitude: -1.3197, longitude: 36.7065),
    Neighborhood(name: 'Westlands, Nairobi', area: 'Westlands', latitude: -1.2683, longitude: 36.8111),
    Neighborhood(name: 'Lang’ata, Nairobi', area: 'Lang’ata', latitude: -1.3639, longitude: 36.7589),
    Neighborhood(name: 'City Centre, Nairobi', area: 'CBD', latitude: -1.286389, longitude: 36.817223),
    Neighborhood(name: 'Village Market, Nairobi', area: 'Gigiri', latitude: -1.2294, longitude: 36.8044),
  ];
}
