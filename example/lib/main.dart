import 'package:flutter/material.dart';
import 'package:flutter_alien/flutter_alien.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final socialService = SocialService.instance;

  @override
  void initState() {
    socialService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example get data'),
      ),
      body: FutureBuilder<MediumChannel>(
        future: socialService.getMediumFeed('flutter'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(snapshot.data.title),
                    subtitle: Text(snapshot.data.description),
                    leading: Image.network(
                      snapshot.data.imageLink,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.mediumPosts.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(snapshot.data.mediumPosts[index].title),
                          subtitle: Text(snapshot
                              .data.mediumPosts[index].pubDate
                              .toString()),
                          onTap: () => launchUrl(
                              Uri.parse(snapshot.data.mediumPosts[index].link)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return snapshot.hasError
              ? Text('Error: ${snapshot.error.toString()}')
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
