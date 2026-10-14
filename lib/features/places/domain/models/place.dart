class MenuItem {
  final String name;
  final String price;

  const MenuItem({
    required this.name,
    required this.price,
  });
}

class ReviewItem {
  final String author;
  final String text;
  final String subtitle;

  const ReviewItem({
    required this.author,
    required this.text,
    this.subtitle = 'Demo review · not a live review feed',
  });
}

class Place {
  final String id;
  final String name;
  final String category; // 'food', 'nightlife', 'activities', 'sights'
  final String photo;
  final List<String> gallery;
  final String area;
  final String distance;
  final String rating;
  final int reviews;
  final String price;
  final String label;
  final String description;
  final String hours;
  final String booking;
  final List<MenuItem> menu;
  final List<ReviewItem> reviewsList;

  const Place({
    required this.id,
    required this.name,
    required this.category,
    required this.photo,
    required this.gallery,
    required this.area,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.label,
    required this.description,
    required this.hours,
    required this.booking,
    this.menu = const [],
    this.reviewsList = const [],
  });

  bool get isTopRated {
    final parsed = double.tryParse(rating) ?? 0.0;
    return parsed >= 4.8;
  }
}
