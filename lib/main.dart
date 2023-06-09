import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// Widget renderTitle = Container(
//     child: Row(
//       children: [
//         Expanded(child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               child: const Text(
//                   '这个是文章的标题',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//
//                   )
//               ),
//             ),
//             new RandomWords()
//           ]
//         ))
//       ]
//     )
// );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
            title: '导航标题',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            ),
            home: const HomePage()));
  }
}

class MyAppState extends ChangeNotifier {
  String randomText = Random().nextInt(100).toString();
  final list = [];

  void getNextText() {
    randomText = Random().nextInt(100).toString();
    notifyListeners();
  }

  void onToggle() {
    if (list.contains(randomText)) {
      list.remove(randomText);
    } else {
      list.add(randomText);
    }
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.randomText;
    var list = appState.list;

    IconData icon;
    icon = list.contains(pair) ? Icons.favorite : Icons.favorite_border;
    return Scaffold(
      body: Row(children: [
        
      ],)
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.randomText;
    var list = appState.list;

    IconData icon;
    icon = list.contains(pair) ? Icons.favorite : Icons.favorite_border;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('A random AWESOME idea:'),
            BigCard(pair: pair),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () => appState.onToggle(),
                  icon: Icon(icon),
                  label: const Text('LIKE'),
                ),
                ElevatedButton(
                  onPressed: () {
                    appState.getNextText();
                  },
                  child: const Text('NEXT'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final String pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.w600,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair, style: style),
      ),
    );
  }
}
