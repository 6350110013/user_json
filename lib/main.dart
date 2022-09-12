import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: "User JSON",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _import = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await jsonDecode(response.toString());
    setState(() {
      _import = data["import"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Users JSON",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Load JSON Data'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _import.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _import.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(_import[index]["username"]),
                      subtitle: Text(_import[index]["email"]),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          (_import[index]["urlAvatar"]),
                        ),
                      ),
                    ),
                  );


                  return Container(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Text(_import[index]["username"]),
                                title: Text(_import[index]["email"]),
                                subtitle: Text(_import[index]["urlAvatar"]),
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
