import 'package:flutter/material.dart';
import 'package:youtubeflutter/screens/student_add.dart';

import 'models/student.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

final avatar =
    "https://png2.cleanpng.com/sh/429187ab5abea4ff03cb18e41d7c196d/L0KzQYm3VME5N5Jsj5H0aYP2gLBuTfF3aaVmip9sb33zhcXskr1qa5Dzi59rdYPsfrb6k71jfaRuhtd8cz36f77ojr02aZU8S6hrYUbmdIq6Vr42P2M5S6U9OEG4QoW3VcM3QWE5TKcELoDxd1==/kisspng-avatar-computer-icons-business-business-woman-5ad736ba6cd936.5724334815240536904459.png";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  List<Student> students = [
    Student.withId(1, "Sezer", "YILDIRIM", 55),
    Student.withId(2, "Kaan", "UZUN", 42),
    Student.withId(2, "Volkan", "GÜRBÜZ", 25)
  ];

  Student selectedStudent = Student.withId(0, "Hiç Kimse", "lastName", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Öğrenci Takip Sistemi")),
        body: buildBody());
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(students[index].firstName +
                        " " +
                        students[index].lastName),
                    subtitle: Text("Sınavdan Aldığı Not: " +
                        students[index].grade.toString() +
                        " [" +
                        students[index].getStatus +
                        "]"),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                    ),
                    trailing: buildStatusIcon(students[index].grade),
                    onTap: () {
                      setState(() {
                        this.selectedStudent = students[index];
                      });
                    },
                    onLongPress: () {
                      print("Uzun Basıldı!");
                    },
                  );
                })),
        Text("Seçili Öğrenci: " + selectedStudent.firstName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.blueAccent,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Yeni Öğrenci")
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentAdd(students)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.orangeAccent,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.update),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Güncelle")
                  ],
                ),
                onPressed: () {
                  print("Güncelle");
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.redAccent,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.delete),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Sil")
                  ],
                ),
                onPressed: () {
                  students.remove(selectedStudent);
                },
              ),
            )
          ],
        )
      ],
    );
  }
}

Widget buildStatusIcon(int grade) {
  if (grade >= 50) {
    return Icon(Icons.done);
  } else if (grade >= 40) {
    return Icon(Icons.album);
  } else {
    return Icon(Icons.clear);
  }
}
