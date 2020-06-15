import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredAmount < 0 || enteredTitle.isEmpty) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        TextField(
            decoration: InputDecoration(labelText: "Title"),
            controller: titleController,
            onSubmitted: (_) => submitData()),
        TextField(
          decoration: InputDecoration(labelText: "Amount"),
          controller: amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => submitData(),
        ),
        Container(
          height: 70,
          child: Row(
            children: <Widget>[
              Text('No date chosen', style: TextStyle(fontWeight: FontWeight.bold),),
              FlatButton(onPressed: () {}, child: Text('Choose Date'),textColor: Theme.of(context).primaryColor,)
            ],
          ),
        ),
        FlatButton(
            onPressed: submitData,
            child: Text(
              "Add Transaction",
              style: TextStyle(color: Colors.purple),
            ))
      ]),
      padding: EdgeInsets.all(10),
    ));
  }
}
