import 'package:flutter/material.dart';
import 'package:materialdesign3example/colors_schemas.dart';

final themeMode = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // funciona a partir do flutter 3.0
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeMode,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: value,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var _selected = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).colorScheme.error; // pegar a cor desejada ex error
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Switch(value: themeMode.value == ThemeMode.dark, onChanged: (isDark){
            themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
          })
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Image.network(
                            fit: BoxFit.cover,
                            'https://cdn.wallpapersafari.com/87/3/VY0aS1.jpg'),
                      ),
                    ),
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text('Pug'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {}, child: const Text('button'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selected,
        onDestinationSelected: (index) {
          setState(() {
            _selected = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        animationDuration: const Duration(seconds: 1),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.abc),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Configuration',
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
