import 'package:evento_app/controller/activity_controller.dart';
import 'package:evento_app/model/activity.dart';
import 'package:evento_app/view/menu.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool _confirmada = false;

  final TextEditingController _palestra = TextEditingController();
  final TextEditingController _palestrante = TextEditingController();
  final TextEditingController _horario = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormFieldState> formState = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(
          "ATIVIDADES",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {},
                ),
                title: Text("Atividade 01"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          _cadastrarAtividade();
        },
      ),
      drawer: Menu(),
    );
  }

  Widget _cadastrarAtividade() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Form(
        key: formKey,
        child: SimpleDialog(
          title: Text("Atividade"),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Título da palestra"),
                controller: _palestra,
                validator: (val) => val == "" ? val : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Palestrante"),
                controller: _palestrante,
                validator: (val) => val == "" ? val : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Horário"),
                controller: _horario,
                validator: (val) => val == "" ? val : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: FormField<bool>(
                key: formState,
                initialValue: _confirmada,
                builder: (FormFieldState<bool> state) {
                  return CheckboxListTile(
                      value: state.value,
                      title: Text("Confirmada ?"),
                      selected: _confirmada,
                      onChanged: state.didChange);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar"),
                ),
                FlatButton(
                  onPressed: () {
                    _confirmada = formState.currentState.value;
                    _cadastraAtividade(globalKey, context, _confirmada);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _cadastraAtividade(GlobalKey<ScaffoldState> globalKey,
      BuildContext context, bool _confirmada) {
    try {
      if (formKey.currentState.validate()) {
        Activity activity = Activity(
            _palestra.text, _palestrante.text, _horario.text, _confirmada);
        ActivityController().addActivity("activity", activity);
        globalKey.currentState.showSnackBar(
            SnackBar(content: Text("Atividade cadastrada com sucesso.")));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ActivityScreen()));
      } else {
        globalKey.currentState.showSnackBar(
            SnackBar(content: Text("Preencha os campos em branco.")));
      }
    } catch (error) {
      print(error);
      globalKey.currentState.showSnackBar(
          SnackBar(content: Text("Não foi possível cadastrar a atividade.")));
    }
  }
}
