

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

class UrlPreview extends StatefulWidget {
  final String? paraString;
  const UrlPreview({ Key? key, this.paraString}): super(key: key);
  @override
  State<UrlPreview> createState() => _UrlPreviewState();
}

class _UrlPreviewState extends State<UrlPreview> {

  final String sampleUrl = "https://novelpia.com/novel/201091?sid=main5";

  String? previewImage = "";

  void urlToMeta(String uri) async {
    print("now run urlToMeata");
    final response = await http.get(Uri.parse(uri), headers: {
      'accept-encoding': 'gzip, deflate, br',
      'accept-language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7',
    }).timeout(const Duration(seconds: 2));
    dom.Document document = parse.parse(response.body);

    String? title = document.head
        ?.querySelector("meta[property='og:title']")
        ?.attributes['content'];
    String? description = document.head
        ?.querySelector("meta[property='og:description']")
        ?.attributes['content'];
    String? image = document.head
        ?.querySelector("meta[property='og:image']")
        ?.attributes['content'];
    previewImage = image;
    String? url = document.head
        ?.querySelector("meta[property='og:url']")
        ?.attributes['content'];
  }

  void _getMetadata(String url) async {
    bool _isValid = _getUrlValid(url);
    if (_isValid) {
      Metadata? _metadata = await AnyLinkPreview.getMetadata(
        link: url,
        cache: Duration(days: 7),
        // proxyUrl: "https://blingvpn.link/",//"https://cors-anywhere.herokuapp.com/", // https://blingvpn.link/
        proxyUrl: "https://cors-anywhere.herokuapp.com/",
      );
      debugPrint(_metadata?.title);
      debugPrint(_metadata?.desc);
      debugPrint(_metadata?.image);
    } else {
      debugPrint("URL is not valid");
    }
  }

  bool _getUrlValid(String url) {
    bool _isUrlValid = AnyLinkPreview.isValidLink(
      url,
      protocols: ['http', 'https'],
      hostWhitelist: ['https://youtube.com/'],
      hostBlacklist: ['https://facebook.com/'],
    );
    return _isUrlValid;
  }

  @override
  void initState() {
    // TODO: implement initState
    // urlToMeta(sampleUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    // 디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text("https://novelpia.com/novel/201091?sid=main5"),

            TextButton(
              onPressed: ()async{
                // final response = await http.get(Uri.parse("https://novelpia.com/novel/201091?sid=main5"));
                // print("response:${response.headers}");
                // urlToMeta(sampleUrl);
                // print("previewImage : $previewImage");

                // Metadata? _metadata = await AnyLinkPreview.getMetadata(
                //   link: sampleUrl,
                //   // cache: Duration(days: 7),
                //   proxyUrl: sampleUrl//"https://cors-anywhere.herokuapp.com/", // Need for web
                // );
                // print(_metadata?.title);

                _getMetadata("https://www.google.com/");
                // _getMetadata("https://github.com/");
              },
              child: Text("url"),
            ),

            Image.network("https://www.youtube.com/img/desktop/yt_1200.png"),


            /*
            AnyLinkPreview(
              link: sampleUrl,
              displayDirection: UIDirection.uiDirectionHorizontal,
              showMultimedia: false,
              bodyMaxLines: 5,
              bodyTextOverflow: TextOverflow.ellipsis,
              titleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
              errorBody: 'Show my custom error body',
              errorTitle: 'Show my custom error title',
              errorWidget: Container(
                color: Colors.grey[300],
                child: Text('Oops!'),
              ),
              errorImage: "https://google.com/",
              cache: Duration(days: 7),
              backgroundColor: Colors.grey[300],
              borderRadius: 12,
              removeElevation: false,
              boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
              onTap: (){}, // This disables tap event
            ),
            AnyLinkPreview(
              link: "https://www.youtube.com/watch?v=w_rGNrHdO5o",
              displayDirection: UIDirection.uiDirectionHorizontal,
              // cache: Duration(hours: 1),
              backgroundColor: Colors.grey[300],
              errorWidget: Container(
                color: Colors.grey[300],
                child: Text('Oops!'),
              ),
              errorImage: sampleUrl,
            ),

            // ============

            AnyLinkPreview(
              link: sampleUrl,
              displayDirection: UIDirection.uiDirectionHorizontal,
              cache: Duration(hours: 1),
              backgroundColor: Colors.grey[300],
              errorWidget: Container(
                color: Colors.grey[300],
                child: Text('Oops!'),
              ),
              errorImage: sampleUrl,
            ),
            SizedBox(height: 25),
            AnyLinkPreview(
              link: sampleUrl,
              displayDirection: UIDirection.uiDirectionHorizontal,
              showMultimedia: false,
              bodyMaxLines: 5,
              bodyTextOverflow: TextOverflow.ellipsis,
              titleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 25),
            AnyLinkPreview(
              displayDirection: UIDirection.uiDirectionHorizontal,
              link: sampleUrl,
              errorBody: 'Show my custom error body',
              errorTitle: 'Next one is youtube link, error title',
            ),
            SizedBox(height: 25),
            AnyLinkPreview(link: sampleUrl),
            SizedBox(height: 25),
            // Custom preview builder
            AnyLinkPreview.builder(
              link: "https://www.youtube.com/watch?v=w_rGNrHdO5o",
              itemBuilder: (context, metadata, imageProvider) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageProvider != null)
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.width * 0.5,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  // Container(
                  //   width: double.infinity,
                  //   color: Theme.of(context).primaryColor.withOpacity(0.6),
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 10, horizontal: 15),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       if (metadata.title != null)
                  //         Text(
                  //           metadata.title!,
                  //           maxLines: 1,
                  //           style:
                  //           const TextStyle(fontWeight: FontWeight.w500),
                  //         ),
                  //       const SizedBox(height: 5),
                  //       if (metadata.desc != null)
                  //         Text(
                  //           metadata.desc!,
                  //           maxLines: 1,
                  //           style: Theme.of(context).textTheme.bodySmall,
                  //         ),
                  //       Text(
                  //         metadata.url ?? sampleUrl,
                  //         maxLines: 1,
                  //         style: Theme.of(context).textTheme.bodySmall,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),

             */
          ],
        ),
      )
    );
  }
}