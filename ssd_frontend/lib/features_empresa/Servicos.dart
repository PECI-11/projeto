class Service {
  final String name;
  final String latitude;
  final String longitude;
  final List<String> images;
  final List<String> imageDescriptions;
  final String userEmail;
  final String serviceType;
  final String district;
  final String county;
  final String parish;
  final String street;

  Service({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.imageDescriptions,
    required this.userEmail,
    required this.serviceType,
    required this.district,
    required this.county,
    required this.parish,
    required this.street,
  });
}

class RestaurantAd extends Service {
  final List<String> establishmentTypes;
  final List<String> menu;
  final String hours;
  final String description;
  final String promo;
  final String email;

  RestaurantAd({
    required String name,
    required String latitude,
    required String longitude,
    required List<String> images,
    required List<String> imageDescriptions,
    required String userEmail,
    required String serviceType,
    required String district,
    required String county,
    required String parish,
    required String street,
    required this.establishmentTypes,
    required this.menu,
    required this.hours,
    required this.description,
    required this.promo,
    required this.email,
  }) : super(
          name: name,
          latitude: latitude,
          longitude: longitude,
          images: images,
          imageDescriptions: imageDescriptions,
          userEmail: userEmail,
          serviceType: serviceType,
          district: district,
          county: county,
          parish: parish,
          street: street,
        );
}

class AccommodationAd extends Service {
  final String bedroomType;
  final String bedroomPrices;
  final String services;

  AccommodationAd({
    required String name,
    required String latitude,
    required String longitude,
    required List<String> images,
    required List<String> imageDescriptions,
    required String userEmail,
    required String serviceType,
    required String district,
    required String county,
    required String parish,
    required String street,
    required this.bedroomType,
    required this.bedroomPrices,
    required this.services,
  }) : super(
          name: name,
          latitude: latitude,
          longitude: longitude,
          images: images,
          imageDescriptions: imageDescriptions,
          userEmail: userEmail,
          serviceType: serviceType,
          district: district,
          county: county,
          parish: parish,
          street: street,
        );
}

class MonumentAd extends Service {
  final String story;
  final String style;
  final String accessibility;
  final String schedule;
  final String price;
  final String activity;
  final String guideVisit;

  MonumentAd({
    required String name,
    required String latitude,
    required String longitude,
    required List<String> images,
    required List<String> imageDescriptions,
    required String userEmail,
    required String serviceType,
    required String district,
    required String county,
    required String parish,
    required String street,
    required this.story,
    required this.style,
    required this.accessibility,
    required this.schedule,
    required this.price,
    required this.activity,
    required this.guideVisit,
  }) : super(
          name: name,
          latitude: latitude,
          longitude: longitude,
          images: images,
          imageDescriptions: imageDescriptions,
          userEmail: userEmail,
          serviceType: serviceType,
          district: district,
          county: county,
          parish: parish,
          street: street,
        );
}
