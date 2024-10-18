class PemanduWisata {
  int? id;
  String? guide;
  String? languages;
  int? rating;
  PemanduWisata({this.id, this.guide, this.languages, this.rating});
  factory PemanduWisata.fromJson(Map<String, dynamic> obj) {
    return PemanduWisata(
        id: obj['id'],
        guide: obj['guide'],
        languages: obj['languages'],
        rating: obj['rating']);
  }
}
