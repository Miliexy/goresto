class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/images/restaurant_Avatar2.png',
      title: 'Restaurant 1',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/images/restaurant_Avatar1.png',
      title: 'Restaurant 2',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
    Category(
      imagePath: 'assets/images/restaurant_Avatar2.png',
      title: 'Restaurant 3',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/images/restaurant_Avatar1.png',
      title: 'Restaurant 4',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/images/tanger.jpg',
      title: 'Tanger',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/casablanca.jpg',
      title: 'Casablanca',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/images/rabat.jpg',
      title: 'Rabat',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/marrakech.jpg',
      title: 'Marrakech',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
  ];
}
