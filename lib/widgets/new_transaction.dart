import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredAmount < 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        TextField(
            decoration: InputDecoration(labelText: "Title"),
            controller: _titleController,
            onSubmitted: (_) => _submitData()),
        TextField(
          decoration: InputDecoration(labelText: "Amount"),
          controller: _amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => _submitData(),
        ),
        Container(
          height: 70,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'No date chosen'
                      : DateFormat.yMEd().format(_selectedDate),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              FlatButton(
                onPressed: _presentDatePicker,
                child: Text('Choose Date'),
                textColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
        RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
            onPressed: _submitData,
            child: Text("Add Transaction"))
      ]),
      padding: EdgeInsets.all(10),
    ));
  }
}
