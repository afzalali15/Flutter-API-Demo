import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/QuotesData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter API Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Quote> _data;

  Future<Quote> getDataAsync() async {
//    await Future.delayed(Duration(seconds: 2));
    var client = http.Client();

    try {
      var response = await client.get('https://quotes.rest/qod');
      if (response.statusCode == 200) {
        var content = response.body;
        var jsonData = json.decode(content);

        var quotesData = QuotesData.fromJson(jsonData);
        var quotes = quotesData.contents.quotes;

        return quotes.first;
      }
    } catch (Exception) {
      throw Exception('something went wrong!');
    } finally {
      client.close();
    }

    return Quote(quote: 'Some random quote', author: 'Afzal');
  }

  @override
  void initState() {
    super.initState();

    _data = getDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Quote of the Day',
              style: TextStyle(fontSize: 48),
            ),
            Card(
              margin: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                child: FutureBuilder<Quote>(
                  future: _data,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                Image.network(snapshot.data.background).image,
                          ),
                          Text(snapshot.data.quote,
                              style: Theme.of(context).textTheme.headline),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '-' + snapshot.data.author,
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                        ],
                      );
                    else if (snapshot.hasError) return Text('No data found!');

                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
