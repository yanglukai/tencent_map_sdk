import 'package:flutter/material.dart';
import 'package:tencent_map_sdk/tencent_map_sdk.dart';
import 'package:tencent_map_example/page/map_page.dart';
import 'package:tencent_map_example/page/searcher_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    TencentMapPlugin.instance.setPrivacyAgreement(true);
    TencentMapPlugin.instance.setApiKey("API_KEY");
    TencentSearcherPlugin.instance.setApiKey("API_KEY", "SecretKey");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('腾讯地图'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Row(),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapPage(),
                  ));
            },
            child: const Text(
              '地图显示',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearcherPage(),
                  ));
            },
            child: const Text(
              '地理信息检索',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
