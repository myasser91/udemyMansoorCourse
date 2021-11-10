// To parse this JSON data, do
//
//     final headlines = headlinesFromJson(jsonString);

import 'dart:convert';

Headlines headlinesFromJson(String str) => Headlines.fromJson(json.decode(str));

String headlinesToJson(Headlines data) => json.encode(data.toJson());

class Headlines {
    Headlines({
        this.status,
        this.totalResults,
        this.articles,
    });

    String? status;
    int? totalResults;
    List<Article> ?articles;

    factory Headlines.fromJson(Map<String, dynamic> json) => Headlines(
        status: json["status"] == null ? null : json["status"],
        totalResults: json["totalResults"] == null ? null : json["totalResults"],
        articles: json["articles"] == null ? null : List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "totalResults": totalResults == null ? null : totalResults,
        "articles": articles == null ? null : List<dynamic>.from(articles!.map((x) => x.toJson())),
    };
}

class Article {
    Article({
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content,
    });

    Source? source;
    String? author;
    String? title;
    String ?description;
    String? url;
    String ?urlToImage;
    String ?publishedAt;
    String ?content;

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: json["publishedAt"] == null ? null : json["publishedAt"],
        content: json["content"] == null ? null : json["content"],
    );

    Map<String, dynamic> toJson() => {
        "source": source == null ? null : source!.toJson(),
        "author": author == null ? null : author,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "url": url == null ? null : url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt": publishedAt == null ? null : publishedAt,
        "content": content == null ? null : content,
    };
}

class Source {
    Source({
        this.id,
        this.name,
    });

    String ?id;
    String? name;

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
    };
}
