import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'watchlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> _articles = [];
  final List<dynamic> _watchList = [];

  void _openWatchList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WatchlistPage(watchList: _watchList),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=nepal&from=2023-02-26&sortBy=publishedAt&apiKey=42037dd664e945e0bdea7e9035dfbe9e'));

      if (response.statusCode == 200) {
        setState(() {
          final data = jsonDecode(response.body);
          _articles = data['articles'];
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          TextButton(
            onPressed: () => _openWatchList(context),
            child: Row(
              children: [
                const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(
                  'My Watchlist (${_watchList.length})',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          final article = _articles[index];
          final isAddedToWatchlist = _watchList.contains(article);

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
                trailing: IconButton(
                  icon: isAddedToWatchlist
                      ? Icon(Icons.check_box)
                        : Icon(Icons.add_box),
                    onPressed: () {
                      setState(() {
                        if (isAddedToWatchlist) {
                          _watchList.remove(article);
                        } else {
                          _watchList.add(article);
                        }
                      });
                    },
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
              child:
              Text(
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
