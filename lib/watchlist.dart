import 'package:flutter/material.dart';

class WatchlistPage extends StatelessWidget {
  final List<dynamic> watchList;

  WatchlistPage({required this.watchList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: ListView.builder(
        itemCount: watchList.length,
        itemBuilder: (context, index) {
          final article = watchList[index];

          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPage(article: article)));
            },
            child: Card(
              child: ListTile(
                leading: article['urlToImage'] != null
                    ? Image.network(
                  article['urlToImage'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                    : SizedBox.shrink(),
                title: Text(
                  article['title'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  article['description'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final dynamic article;

  DetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              Image.network(article['urlToImage']),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                article['title'] ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                article['description'] ?? '',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                article['content'] ?? '',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
