import 'package:expert_system/questions.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expert system',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Question> question;

  @override
  void initState() {
    super.initState();
    question = getQuestion(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expert system'),
        centerTitle: true,
      ),
      body: FutureBuilder<Question>(
        future: question,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return
              SafeArea(
                child: Column(children: [
              Text(
                snapshot.data!.question,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: ListView.builder(
                itemCount: snapshot.data?.answers.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${snapshot.data?.answers[index].value}'),
                      subtitle: Text('${snapshot.data?.answers[index].id}'),
                      leading: Text(''),
                      isThreeLine: true,
                    ),
                  );
                },
              )
              ),
            ],)
              );
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
