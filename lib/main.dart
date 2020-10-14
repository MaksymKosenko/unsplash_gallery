import 'package:flutter/material.dart';
import 'package:unsplash_gallery/api_manager.dart';
import 'package:unsplash_gallery/unsplash_pictures_inf.dart';
import 'ImageViewScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<UnsplashData>> _dataModel;

  @override
  void initState() {
    _dataModel = API_Manager().getPictures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Gallery app',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Unsplash Gallery'),
        ),
        body: Center(
          child: FutureBuilder(
            future: _dataModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data[index];
                    return Container(
                      height: 150,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ImageViewScreen(link: article.urls.regular)));
                            },
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: AspectRatio(
                                  aspectRatio: 1.5,
                                  child: Image.network(
                                    article.urls.thumb,
                                    fit: BoxFit.cover,
                                  ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text('username:', style: TextStyle(fontStyle: FontStyle.italic)),
                                Text(
                                  article.user.username,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 3),
                                Text('description:', style: TextStyle(fontStyle: FontStyle.italic)),
                                if (article.altDescription != null)
                                  Text(
                                    article.altDescription.toString(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 17),
                                  )
                                else
                                  Text('no description', style: TextStyle(fontSize: 17, color: Colors.black26),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
