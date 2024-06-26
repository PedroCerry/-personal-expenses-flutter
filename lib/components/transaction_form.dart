import 'package:flutter/material.dart';

class Transactionform extends StatefulWidget {
  final void Function(String, double) onSubmit;

  Transactionform(this.onSubmit);

  @override
  State<Transactionform> createState() => _TransactionformState();
}

class _TransactionformState extends State<Transactionform> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();
  DateTime _selectedDate;

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              // onChanged: (newValue) => title = newValue,
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              // onChanged: (newValue) => value = newValue,
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text('Nenhuma data selecionada!'),
                  ElevatedButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Text('Nova Transação',
                      style: Theme.of(context).textTheme.labelLarge),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
