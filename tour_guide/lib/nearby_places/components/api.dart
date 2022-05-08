import 'package:http/http.dart' as http;
import 'package:tour_guide/nearby_places/components/place_result.dart';

class Api{

  Future<PlaceResult> getApi(double latitude,double longitude,String serviceType) async {
    final API_KEY = "AIzaSyCXKvaEoZ3IPetgGzz8bMGF_4H8FAJ129k";
    final RADIUS = 10000;
    final baseUrl =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

    String url =
        '$baseUrl?key=$API_KEY&location=$latitude,$longitude&radius=$RADIUS&type=$serviceType';
    print(url);
    final response = await http.get(Uri.parse(url));


    if (response.statusCode == 200) {
      return placeResultFromJson(response.body);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }
}