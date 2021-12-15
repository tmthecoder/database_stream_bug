import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database_bug_sample/second_page.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<MyHomePage> {

  late final TabController _controller = TabController(length: 2, vsync: this);
  GlobalKey tabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(text: "Tab 1",),
            Tab(text: "Tab 2",),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SecondPage())),
            icon: const Icon(Icons.settings))
        ],
      ),
      body: TabBarView(
        controller: _controller,
        key: tabKey,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<DatabaseEvent>(
                  stream: FirebaseDatabase.instance.ref('test-val').onValue,
                  builder: (context, snapshot) {
                    String value = (snapshot.data?.snapshot.value ?? "") as String;
                    return Text("Database Value: $value");
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Random r = Random();
                    String nVal = "${r.nextInt(1000)}";
                    FirebaseDatabase.instance.ref('test-val').set(nVal);
                  },
                  child: const Text("Change Value")
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                StreamBuilder<DatabaseEvent>(
                  stream: FirebaseDatabase.instance.ref('test-val').onValue,
                  builder: (context, snapshot) {
                    String value = (snapshot.data?.snapshot.value ?? "") as String;
                    return Text("Database Value: $value");
                  }
                ),
                ElevatedButton(
                    onPressed: () {
                      Random r = Random();
                      String nVal = "${r.nextInt(1000)}";
                      FirebaseDatabase.instance.ref('test-val').set(nVal);
                    },
                    child: const Text("Change Value")
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
