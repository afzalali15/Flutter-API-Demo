class QuotesData {
  Success success;
  Contents contents;

  QuotesData({
    this.success,
    this.contents,
  });

  factory QuotesData.fromJson(Map<String, dynamic> json) => QuotesData(
        success: Success.fromJson(json["success"]),
        contents: Contents.fromJson(json["contents"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success.toJson(),
        "contents": contents.toJson(),
      };
}

class Contents {
  List<Quote> quotes;
  String copyright;

  Contents({
    this.quotes,
    this.copyright,
  });

  factory Contents.fromJson(Map<String, dynamic> json) => Contents(
        quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
        copyright: json["copyright"],
      );

  Map<String, dynamic> toJson() => {
        "quotes": List<dynamic>.from(quotes.map((x) => x.toJson())),
        "copyright": copyright,
      };
}

class Quote {
  String quote;
  String length;
  String author;
  List<String> tags;
  String category;
  DateTime date;
  String permalink;
  String title;
  String background;
  String id;

  Quote({
    this.quote,
    this.length,
    this.author,
    this.tags,
    this.category,
    this.date,
    this.permalink,
    this.title,
    this.background,
    this.id,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        quote: json["quote"],
        length: json["length"],
        author: json["author"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        category: json["category"],
        date: DateTime.parse(json["date"]),
        permalink: json["permalink"],
        title: json["title"],
        background: json["background"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "quote": quote,
        "length": length,
        "author": author,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "category": category,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "permalink": permalink,
        "title": title,
        "background": background,
        "id": id,
      };
}

class Success {
  int total;

  Success({
    this.total,
  });

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}
