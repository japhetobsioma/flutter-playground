import 'package:flutter/material.dart';

import 'database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(
                'insert',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _insert();
              },
            ),
            RaisedButton(
              child: Text(
                'query',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _query();
              },
            ),
            RaisedButton(
              child: Text(
                'update',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _update();
              },
            ),
            RaisedButton(
              child: Text(
                'delete',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _delete();
              },
            ),
            RaisedButton(
              child: Text(
                'delete all',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _deleteAll();
              },
            ),
            RaisedButton(
              child: Text(
                'get current date',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _getCurrentDate();
              },
            ),
            RaisedButton(
              child: Text(
                'get current time',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _getCurrentTime();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert() async {
    final currentDate = await dbHelper.currentDate();

    // row to insert
    var row = <String, dynamic>{
      DatabaseHelper.columnName: 'Bob',
      DatabaseHelper.columnAge: 23,
      DatabaseHelper.columnDate: currentDate[0]['date(\'now\')']
    };

    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    var row = <String, dynamic>{
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: 'Mary',
      DatabaseHelper.columnAge: 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  void _deleteAll() async {
    await dbHelper.deleteAll();
  }

  void _getCurrentDate() async {
    final currentDate = await dbHelper.currentDate();
    print('query current date:');
    currentDate.forEach((row) => print(row));
  }

  void _getCurrentTime() async {
    final currentTime = await dbHelper.currentTime();
    print('query current time:');
    currentTime.forEach((row) => print(row));
  }
}
