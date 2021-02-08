class MPItemModel {
  final String image;
  final String word;
  final int backgroundColor;
  final int id;
  final int realId;

  const MPItemModel(
      {this.image, this.backgroundColor, this.word, this.id, this.realId});

  factory MPItemModel.fromMap(int id, int realId, Map<String, dynamic> json) =>
      MPItemModel(
        id: id,
        realId: realId,
        image: json["image"],
        word: json["word"],
        backgroundColor: json["backgroundColor"],
      );

  Map<String, dynamic> toMap() => {
        "image": image,
        "word": word,
        "backgroundColor": backgroundColor,
      };

  MPItemModel copyWith(
      {int id, int realId, String image, String word, int backgroundColor}) {
    return MPItemModel(
      id: id ?? this.id,
      realId: realId ?? this.realId,
      image: image ?? this.image,
      word: word ?? this.word,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
