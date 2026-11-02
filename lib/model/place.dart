class Place {
  final String name;
  final String location;
  final String? linklocation;
  final String? jamBuka;
  final String descriptionjamBuka;
  final String descriptionkecualijamBuka;
  final String descriptionindonesia;
  final String descriptioninggris;
  final String imageAsset;
  final List<String> imageUrls;

  const Place({
    required this.name,
    required this.location,
    this.linklocation,
    this.jamBuka,
    required this.descriptionjamBuka,
    required this.descriptionkecualijamBuka,  
    required this.descriptionindonesia,
    required this.descriptioninggris,
    required this.imageAsset,
    required this.imageUrls,
  });
}