class FlightBookingInputModel{

   String tripType = '';
   String departureCity = '';
   String arrivalCity = '';
   String departureDate = '';
   String numberOfAdults = '';
   String numberOfChildren = '';
   String numberOfInfants = '';
   String cabinClass = '';

  FlightBookingInputModel({
    this.tripType = 'onewaytrip',
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDate,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.numberOfInfants,
    required this.cabinClass,
  });

  bool isFlightBookingModelHasEmptyField(){

    if(departureCity.isEmpty || arrivalCity.isEmpty || departureDate.isEmpty || numberOfAdults.isEmpty || numberOfChildren.isEmpty || numberOfInfants.isEmpty || cabinClass.isEmpty){
      return true;
    }

    return false;
  }
}

