import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

import '../proivder/histroy_provider.dart';

late InAppWebViewController? _webViewController;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleController controller1 = Provider.of<GoogleController>(context);
    return SafeArea(
      child: Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BottomSheet(
            shape: Border(),
            onClosing: () {},
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  // LinearProgressIndicator(
                  //  semanticsLabel: 'Linear progress indicator',
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            InAppWebView(
                              initialUrlRequest: URLRequest(
                                  url: WebUri("https://www.google.com")),
                              onWebViewCreated:
                                  (InAppWebViewController controller) {
                                _webViewController = controller;
                              },
                            );
                          },
                          child: Icon(
                            Icons.home,
                            size: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller1.setData(data!,
                                'https://www.${controller1.m1}.com/search?q=$data');
                            Fluttertoast.showToast(
                                msg: "Save Data Successfully !!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Icon(
                            Icons.bookmark_add_outlined,
                            size: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _webViewController?.goBack();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            size: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _webViewController?.reload();
                          },
                          child: Icon(
                            Icons.restart_alt_rounded,
                            size: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _webViewController?.goForward();
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(
          title: SizedBox(
            height: 40,
            child: TextField(
              controller: controller1.txtSearch,
              onSubmitted: (value) {
                _webViewController?.loadUrl(
                  urlRequest: URLRequest(
                    url: WebUri(
                        "https://www.${controller1.m1}.com/search?q=$value"),
                  ),
                );

                data = controller1.txtSearch.text;
                controller1.searchHistory(
                    data!, 'https://www.${controller1.m1}.com/search?q=$data');

                print('-------------------------------->');
              },
              decoration: InputDecoration(
                // fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                // fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search here..",
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),

          // centerTitle: true,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    controller1.getList();
                    showDialog(
                      context: context,
                      builder: (context) => Dialog.fullscreen(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Histroy',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (controller1.urlData.length == 0)
                              ? Text('No Data Save ')
                              : Column(
                                  children: [
                                    ...List.generate(
                                      controller1.dataStore.length,
                                      (index) => Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              data =
                                                  controller1.dataStore[index];
                                              Navigator.of(context).pop();
                                              // });
                                              _webViewController?.loadUrl(
                                                urlRequest: URLRequest(
                                                  url: WebUri(controller1
                                                      .urlData[index]),
                                                ),
                                              );
                                            },
                                            title: Text(
                                              controller1.dataStore[index],
                                            ),
                                            subtitle: Text(
                                                controller1.urlData[index]),
                                            trailing: InkWell(
                                                onTap: () {
                                                  controller1.removeData(index);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Icon(Icons.close)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      )),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.bookmark),
                      Text('All Book Mark'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    controller1.getList2();
                    showDialog(
                      context: context,
                      builder: (context) => Dialog.fullscreen(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Histroy',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (controller1.searchUrlData.length == 0)
                              ? Text('No Data Save ')
                              : Column(
                                  children: [
                                    ...List.generate(
                                      controller1.searchData.length,
                                      (index) => Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              data =
                                                  controller1.searchData[index];
                                              Navigator.of(context).pop();
                                              _webViewController?.loadUrl(
                                                urlRequest: URLRequest(
                                                  url: WebUri(controller1
                                                      .searchUrlData[index]),
                                                ),
                                              );
                                            },
                                            title: Text(
                                              controller1.searchData[index],
                                            ),
                                            subtitle: Text(controller1
                                                .searchUrlData[index]),
                                            trailing: InkWell(
                                                onTap: () {
                                                  controller1
                                                      .removeSearchData(index);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Icon(Icons.close)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      )),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.search_outlined),
                      Text('Histroy'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Browser'),
                        actions: [
                          RadioListTile(
                              title: const Text('Google'),
                              value: 'Google',
                              groupValue: controller1.m1,
                              onChanged: (value) {
                                controller1.searchengine(value!, data);
                                _webViewController?.loadUrl(
                                  urlRequest: URLRequest(
                                    url: WebUri(
                                        "https://www.${controller1.m1}.com/search?q=$data"),
                                  ),
                                );

                                Navigator.of(context).pop();
                              }),
                          RadioListTile(
                            title: const Text('Yahoo'),
                            value: 'Yahoo',
                            groupValue: controller1.m1,
                            onChanged: (value) {
                              controller1.searchengine(value!, data);
                              _webViewController?.loadUrl(
                                urlRequest: URLRequest(
                                  url: WebUri(
                                      "https://www.${controller1.m1}.com/search?q=$data"),
                                ),
                              );

                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: const Text('Bing'),
                            value: 'Bing',
                            groupValue: controller1.m1,
                            onChanged: (value) {
                              controller1.searchengine(value!, data);

                              _webViewController?.loadUrl(
                                urlRequest: URLRequest(
                                  url: WebUri(
                                      "https://www.${controller1.m1}.com/search?q=$data"),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: const Text('Duck Duck Go'),
                            value: 'DuckDuckGO',
                            groupValue: controller1.m1,
                            onChanged: (value) {
                              controller1.searchengine(value!, data);
                              _webViewController?.loadUrl(
                                urlRequest: URLRequest(
                                  url: WebUri(
                                      "https://www.${controller1.m1}.com/search?q=$data"),
                                ),
                              );

                              // controller1.searchengine(value!,data);
                              Navigator.of(context).pop();

                              // });
                            },
                          ),
                        ],
                      ),
                    );
                    // });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.content_paste_search_rounded),
                      Text('Browser')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: InAppWebView(
          initialUrlRequest:
              URLRequest(url: WebUri('https://www.${controller1.m1}.com/')),
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var url = navigationAction.request.url.toString();
            Uri uri = Uri.parse(url);
            if (controller1.m1 == 'google') {
              data = uri.queryParameters['q']!;
            } else if (controller1.m1 == 'bing') {
              data = uri.queryParameters['q']!;
            } else if (controller1.m1 == 'yahoo') {
              data = uri.queryParameters['p']!;
            }
            return NavigationActionPolicy.ALLOW;
          },
        ),
      ),
    );
  }
}
