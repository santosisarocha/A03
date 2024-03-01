import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/discipline1': (context) => DisciplineScreen(disciplineName: 'Disciplina 1'),
        '/discipline2': (context) => DisciplineScreen(disciplineName: 'Disciplina 2'),
        '/discipline3': (context) => DisciplineScreen(disciplineName: 'Disciplina 3'),
        '/discipline4': (context) => DisciplineScreen(disciplineName: 'Disciplina 4'),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas do Aluno'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/discipline1');
          },
          child: Text('Inserir Notas'),
        ),
      ),
    );
  }
}

class DisciplineScreen extends StatefulWidget {
  final String disciplineName;

  DisciplineScreen({required this.disciplineName});

  @override
  _DisciplineScreenState createState() => _DisciplineScreenState();
}

class _DisciplineScreenState extends State<DisciplineScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = List.generate(3, (_) => TextEditingController());
  String? studentName;
  double? average;
  bool? passed;

  void _calculateAverage() {
    if (_formKey.currentState!.validate()) {
      double sum = 0.0;
      for (var controller in _controllers) {
        sum += double.parse(controller.text);
      }
      setState(() {
        average = sum / 3;
        passed = average! >= 7.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.disciplineName),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome do Aluno'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do aluno';
                  }
                  return null;
                },
                onSaved: (value) {
                  studentName = value;
                },
              ),
              SizedBox(height: 20.0),
              for (int i = 0; i < 3; i++)
                TextFormField(
                  controller: _controllers[i],
                  decoration: InputDecoration(labelText: 'Nota ${i + 1}'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a nota';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _calculateAverage();
                },
                child: Text('Calcular Média'),
              ),
              SizedBox(height: 20.0),
              if (average != null && passed != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Média: ${average!.toStringAsFixed(2)}'),
                    Text(passed! ? 'Aprovado' : 'Reprovado', style: TextStyle(fontWeight: FontWeight.bold, color: passed! ? Colors.green : Colors.red)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
