import 'package:dekornata_submission_test/utils/product_seeds.dart';
import 'package:dekornata_submission_test/utils/uuid.dart';

class Product {
  String id;
  String title;
  ImageTitle imageTitle;
  ProductCategory category;
  double cost;

  Product({
    this.id,
    this.title,
    this.imageTitle,
    this.category,
    this.cost,
  });

  String get imageUrl => productImageFile[imageTitle];
  String get uniqueId => Uuid().generateV4();
}

enum ProductCategory {
  WoodCraft,
  WeaveCraft,
  Ceramics,
}

enum ImageTitle {
  RectangularTissueBox,
  AiraTray,
  MahoganyTray,
  SquareTissueBox,
  HexagonCoaster,
  WoodenCoaster,
  CacaCoaster,
  CielServingBoard,
  StorageBox,
  SquareTray,
  ClemencePlate,
  CookiePlate,
  WoodCraft,
  TariTissueBox,
  PlacematePlacemat,
  EcengPlacematCoaster,
  AkilaBambooBasketTray,
  RadiBamboo,
  LakaBambooTray,
  RectaEcengBasketTray,
  CaniMiniBasket,
  SilaBasketSet,
  KibuBambooBasket,
  TinsaBambooBasketTray,
  NaruBambooTray,
  WeaveCraft,
  AlirPlate,
  RupaPlate,
  KilauCup,
  PekatCup,
  PijarJug,
  SemarTeapot,
  GeloraPitcher,
  SeduhTeapot,
  KalaCup,
  EratSaltnPepperStacker,
  KibasTeacup,
  LesungCupSet,
  Ceramics,
}

class NewProduct {
  double cost;
  String title;
  ProductCategory category;
  DateTime dateAdded;

  @override
  String toString() {
    return 'NewProduct{cost: $cost, title: $title, category: $category}';
  }
}
