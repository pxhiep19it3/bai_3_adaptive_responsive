import 'package:bai_3_adaptive_responsive/src/people.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 480) {
            return WideLayout();
          } else {
            return NarrowLayout();
          }
        },
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout({Key? key}) : super(key: key);

  @override
  _WideLayoutState createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Person? _person;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PeopleList(
              personTapCallBack: (person) => setState(() => _person = person)),
          flex: 2,
        ),
        Expanded(
          child: _person == null ? Placeholder() : PersonDetail(_person!),
          flex: 3,
        ),
      ],
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeopleList(
      personTapCallBack: (person) =>
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text(person.name),
                  ),
                  body: PersonDetail(person)))),
    );
  }
}

class PeopleList extends StatelessWidget {
  final void Function(Person) personTapCallBack;
  const PeopleList({required this.personTapCallBack});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var person in people)
          ListTile(
              leading: Image.network(person.picture),
              title: Text(person.name),
              onTap: () => personTapCallBack(person))
      ],
    );
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;
  const PersonDetail(this.person);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(person.name),
          Text(person.phone),
        ],
      ),
    );
  }
}
