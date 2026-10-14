import '../../domain/models/place.dart';

class LocalPlacesDataSource {
  static String _image(String id) =>
      'https://images.unsplash.com/$id?auto=format&fit=crop&w=1200&q=85';

  static final String cityPhoto = _image('photo-1611348524140-53c9a25263d6');
  static final String safariPhoto = _image('photo-1634662101368-fa8021773862');
  static final String foodPhoto = _image('photo-1414235077428-338989a2e8c0');
  static final String barPhoto = _image('photo-1514933651103-005eec06c04b');

  static final List<Place> defaultPlaces = [
    Place(
      id: 'giraffe',
      name: 'Giraffe Centre',
      category: 'activities',
      photo: safariPhoto,
      gallery: [
        safariPhoto,
        _image('photo-1733705940512-87d66e3fcd9c'),
        _image('photo-1736680839097-d1a2fefe7de5'),
      ],
      area: 'Lang’ata',
      distance: '7.6 km',
      rating: '4.8',
      reviews: 1240,
      price: 'KSh 1,500',
      label: 'A little wild, a lot wonderful',
      description:
          'Get a little closer to the gentle giants of Nairobi. Wander the nature trail, meet endangered Rothschild’s giraffes, and discover the people protecting their future.',
      hours: '9:00 AM – 5:00 PM',
      booking: 'Walk-ins welcome. Arrive early for a quieter visit.',
      reviewsList: const [
        ReviewItem(
          author: 'Traveler Review',
          text:
              '“A beautiful way to spend an afternoon in Nairobi. Go early, take your time, and bring your camera.”',
        ),
      ],
    ),
    Place(
      id: 'talisman',
      name: 'The Talisman',
      category: 'food',
      photo: foodPhoto,
      gallery: [
        foodPhoto,
        _image('photo-1517248135467-4c7edcad34c4'),
        barPhoto,
      ],
      area: 'Karen',
      distance: '2.4 km',
      rating: '4.7',
      reviews: 824,
      price: 'KSh 2,000–4,000',
      label: 'A taste of the neighbourhood',
      description:
          'A leafy garden, a beautiful plate, and a very Nairobi kind of afternoon. Discover globally inspired dishes made with local ingredients in this beloved neighbourhood restaurant.',
      hours: '12:00 PM – 10:00 PM',
      booking: 'Reservations recommended for evenings and weekends.',
      menu: const [
        MenuItem(name: 'Garden salad', price: 'KSh 850'),
        MenuItem(name: 'Seasonal fish', price: 'KSh 2,200'),
        MenuItem(name: 'House dessert', price: 'KSh 750'),
      ],
      reviewsList: const [
        ReviewItem(
          author: 'Foodie Journal',
          text:
              '“The garden ambiance in Karen is unmatched. The feta and coriander samosas are legendary.”',
        ),
      ],
    ),
    Place(
      id: 'hero',
      name: 'Hero Bar',
      category: 'nightlife',
      photo: barPhoto,
      gallery: [barPhoto, foodPhoto],
      area: 'Village Market',
      distance: '4.2 km',
      rating: '4.7',
      reviews: 318,
      price: 'KSh 1,200–2,500',
      label: 'Stay for one more',
      description:
          'Creative cocktails and a playful comic-themed atmosphere make this a memorable place to discover Nairobi after dark.',
      hours: '5:00 PM – 12:00 AM',
      booking: 'Reservations recommended. Age 18+ only.',
      reviewsList: const [
        ReviewItem(
          author: 'Night Owl Guide',
          text:
              '“Super stylish speakeasy vibe with inventive Japanese-inspired cocktails.”',
        ),
      ],
    ),
    Place(
      id: 'kicc',
      name: 'KICC Rooftop',
      category: 'sights',
      photo: cityPhoto,
      gallery: [cityPhoto, safariPhoto],
      area: 'City Centre',
      distance: '6.4 km',
      rating: '4.6',
      reviews: 946,
      price: 'KSh 500',
      label: 'A city from a new perspective',
      description:
          'Take in panoramic views of the green city in the sun from one of its most recognisable architectural landmarks.',
      hours: '9:00 AM – 6:00 PM',
      booking: 'Check current rooftop access with the venue before visiting.',
      reviewsList: const [
        ReviewItem(
          author: 'Nairobi Explorer',
          text:
              '“The 360-degree helipad view is the best vantage point of Nairobi skyline anywhere.”',
        ),
      ],
    ),
    Place(
      id: 'nairobi-national-park',
      name: 'Nairobi National Park',
      category: 'activities',
      photo: safariPhoto,
      gallery: [safariPhoto, cityPhoto],
      area: 'Lang’ata',
      distance: '10.2 km',
      rating: '4.9',
      reviews: 3410,
      price: 'KSh 430–4,300',
      label: 'Wilderness against skyscrapers',
      description:
          'The world’s only wildlife capital. Lions, endangered black rhinos, and zebras roaming with the city skyline rising across the horizon.',
      hours: '6:00 AM – 6:30 PM',
      booking: 'Book via eCitizen or pay via M-Pesa/Card at the KWS gate.',
      reviewsList: const [
        ReviewItem(
          author: 'Safari Enthusiast',
          text:
              '“An early morning 6:30 AM game drive is magical. Spotted lions within 20 minutes!”',
        ),
      ],
    ),
    Place(
      id: 'karura-forest',
      name: 'Karura Forest',
      category: 'activities',
      photo: _image('photo-1448375240586-882707db888b'),
      gallery: [
        _image('photo-1448375240586-882707db888b'),
        _image('photo-1511497584788-87676104235f'),
      ],
      area: 'Gigiri',
      distance: '5.1 km',
      rating: '4.8',
      reviews: 1890,
      price: 'KSh 100–600',
      label: 'Lush urban canopy & waterfalls',
      description:
          'An urban sanctuary championed by Nobel Laureate Wangari Maathai. Shaded trails for jogging, cycling, tranquil waterfalls, and Mau Mau caves.',
      hours: '6:00 AM – 7:00 PM',
      booking: 'Cashless gate entry (M-Pesa or Card only). Bike rentals available.',
      reviewsList: const [
        ReviewItem(
          author: 'Nature Trail Fan',
          text:
              '“Rent a bike at the KFEET gate and ride along the eucalyptus trails to the waterfall.”',
        ),
      ],
    ),
  ];

  Future<List<Place>> getPlaces() async {
    return defaultPlaces;
  }

  Future<Place?> getPlaceById(String id) async {
    try {
      return defaultPlaces.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
