enum EnumLocation {
  academicBlocks('AcademicBlocks', 'Blocos Acadêmicos'),
  touristicPoints('TouristsPoints', 'Pontos Turísticos'),
  banks('Banks', 'Bancos'),
  restaurants('Restaurants', 'Restaurantes'),
  helthServices('HelthServices', 'Serviços de Saúde'),
  libraries('Libraries', 'Bibliotecas'),
  sportsCenters('SportsCenters', 'Centros Esportivos'),
  transports('Transports', 'Transportes'),
  parkingLots('ParkingLots', 'Estacionamentos'),
  generalBuildings('GeneralBuildings', 'Prédios Gerais'),
  ;

  const EnumLocation(this.jsonName, this.title);

  final String jsonName;
  final String title;

  @override
  String toString() => title;
}
