import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(
          title: 'Getting Product Informations for E-Commerce'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final product = TextEditingController();

  Future<void> fetchProductInfo() async {
    if (product.text == '') return;
    var link = product.text.replaceAll('https://www.trendyol.com', '');
    print(link);
    String header = '';
    await get(Uri.https('www.trendyol.com', link)).then((data) {
      setState(() {
        header = data.body
            .replaceAll('\n', '')
            .replaceAll('\t', '')
            .replaceAll('  ', '');
        RegExp search = new RegExp(
            '<div class="product-container" data-drroot="product-detail"><div></div>(.*?)<div class="all-features"><div class="opacity-layout"></div><div class="feature-buttons"><a rel="nofollow" class="button-all-features">ÜRÜNÜN TÜM ÖZELLİKLERİ</a></div></div></div></div></div></div></div>');
        Match? matched = search.firstMatch(header);
        header = matched!.group(1)!;
        RegExp search2 = new RegExp(
            '<div class="base-product-image">(.*?)</div></div></div></div>');
        Match? matched2 = search2.firstMatch(header);
        header = matched2!.group(1)!;
        RegExp search3 =
            new RegExp('<img loading="lazy" src="(.*?)" alt="(.*?)"/>');
        Match? matched3 = search3.firstMatch(header);
        header = matched3!.group(2)!;
        print('Header: $header');
      });
    }).onError((error, stackTrace) {
      print('object');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Row(children: [
              Text('Product Link:'),
              SizedBox(width: 5),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: product,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      letterSpacing: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    cursorWidth: 1.5,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Column(children: []),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => fetchProductInfo(),
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
    );
  }
}
/**
                                                        try {
                                                          await Dio().download(
                                                            downloadUrl['URL'],
                                                            '/storage/emulated/0/Download/${downloadUrl.id}',
                                                            // '${externalDir!.path}${downloadUrl.id}',
                                                            onReceiveProgress:
                                                                (count, total) {
                                                              print(
                                                                  '${(count / 1024).ceil()}/${(count / 1024).ceil()}');
                                                              setState(() {
                                                                process = true;
                                                                this.count =
                                                                    (count /
                                                                            1024)
                                                                        .ceil();
                                                                this.total =
                                                                    (count /
                                                                            1024)
                                                                        .ceil();
                                                                if (count ==
                                                                    total) {
                                                                  process =
                                                                      false;
                                                                }
                                                              });
                                                            },
                                                          );
                                                          print(
                                                              "Download Completed.");
                                                        } catch (e) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  new SnackBar(
                                                            content: Text(
                                                                'Yükleme Başarısız! Hata: ' +
                                                                    e.toString()),
                                                          ));
                                                          // print("Download Failed.\n" + e.toString());
                                                        }
 */
