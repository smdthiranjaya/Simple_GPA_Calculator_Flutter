import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Changed the theme to blue
      ),
      home: const MyHomePage(title: 'GPA Calculator'),
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
  List<Student> students = [];
  TextEditingController studentNameController = TextEditingController();
  TextEditingController subject1Controller = TextEditingController();
  TextEditingController subject2Controller = TextEditingController();
  TextEditingController subject3Controller = TextEditingController();
  TextEditingController subject4Controller = TextEditingController();
  TextEditingController subject5Controller = TextEditingController();
  double gpa = 0.0;

  void addStudent(String name, double gpa) {
    setState(() {
      students.add(Student(name: name, gpa: gpa));
    });
  }

  void addSubjectMarks(Student student, List<double> subjectMarks) {
    setState(() {
      student.subjectMarks = subjectMarks;
      student.calculateGPA();
      calculateOverallGPA();
    });
  }

  void removeStudent(Student student) {
    setState(() {
      students.remove(student);
      calculateOverallGPA();
    });
  }

  void calculateOverallGPA() {
    double totalGPA = 0.0;
    students.forEach((student) {
      totalGPA += student.gpa;
    });
    gpa = totalGPA / students.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'GPA:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  gpa.toStringAsFixed(1),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: studentNameController,
                  decoration: InputDecoration(
                    labelText: 'Student Name',
                  ),
                  onChanged: (value) {
                    // Implement student name input handling
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: subject1Controller,
                        decoration: InputDecoration(
                          labelText: 'Subject 1',
                        ),
                        onChanged: (value) {
                          calculateAndUpdateGPA();
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: subject2Controller,
                        decoration: InputDecoration(
                          labelText: 'Subject 2',
                        ),
                        onChanged: (value) {
                          calculateAndUpdateGPA();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: subject3Controller,
                        decoration: InputDecoration(
                          labelText: 'Subject 3',
                        ),
                        onChanged: (value) {
                          calculateAndUpdateGPA();
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: subject4Controller,
                        decoration: InputDecoration(
                          labelText: 'Subject 4',
                        ),
                        onChanged: (value) {
                          calculateAndUpdateGPA();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: subject5Controller,
                  decoration: InputDecoration(
                    labelText: 'Subject 5',
                  ),
                  onChanged: (value) {
                    calculateAndUpdateGPA();
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    final studentName = studentNameController.text;
                    final subject1 = double.parse(subject1Controller.text);
                    final subject2 = double.parse(subject2Controller.text);
                    final subject3 = double.parse(subject3Controller.text);
                    final subject4 = double.parse(subject4Controller.text);
                    final subject5 = double.parse(subject5Controller.text);
                    final subjectMarks = [subject1, subject2, subject3, subject4, subject5];
                    final gpa = calculateGPA(subjectMarks);
                    addStudent(studentName, gpa);
                    studentNameController.clear();
                    subject1Controller.clear();
                    subject2Controller.clear();
                    subject3Controller.clear();
                    subject4Controller.clear();
                    subject5Controller.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'GPA Dashboard',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  children: students.map((student) {
                    return Card(
                      child: ListTile(
                        title: Text('Name: ${student.name}'),
                        subtitle: Text('GPA: ${student.gpa.toStringAsFixed(1)}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeStudent(student);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calculateAndUpdateGPA() {
    final subject1 = double.tryParse(subject1Controller.text) ?? 0.0;
    final subject2 = double.tryParse(subject2Controller.text) ?? 0.0;
    final subject3 = double.tryParse(subject3Controller.text) ?? 0.0;
    final subject4 = double.tryParse(subject4Controller.text) ?? 0.0;
    final subject5 = double.tryParse(subject5Controller.text) ?? 0.0;
    final subjectMarks = [subject1, subject2, subject3, subject4, subject5];
    final gpa = calculateGPA(subjectMarks);
    setState(() {
      this.gpa = gpa;
    });
  }

  double calculateGPA(List<double> subjectMarks) {
    double totalMarks = subjectMarks.reduce((a, b) => a + b);
    double gpa = totalMarks / subjectMarks.length;
    return gpa;
  }
}

class Student {
  final String name;
  double gpa;
  List<double> subjectMarks;

  Student({required this.name, required this.gpa, this.subjectMarks = const []});

  void calculateGPA() {
    double totalMarks = subjectMarks.reduce((a, b) => a + b);
    gpa = totalMarks / subjectMarks.length;
  }
}
