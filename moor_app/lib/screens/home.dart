import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../database/app_db.dart';
import '../models/database.dart';

final appDatabaseProvider =
    StateNotifierProvider((ref) => AppDatabaseNotifier());

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: buildTaskList(),
          ),
          NewTaskInput(),
        ],
      ),
    );
  }
}

class buildTaskList extends HookWidget {
  const buildTaskList();

  @override
  Widget build(BuildContext context) {
    final _databaseModel = useProvider(appDatabaseProvider.state);

    return StreamBuilder(
      stream: _databaseModel.watchAllTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final _tasks = snapshot.data ?? [];

        return ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (_, index) {
            final _itemTask = _tasks[index];
            return _buildListItem(
              itemTask: _itemTask,
            );
          },
        );
      },
    );
  }
}

class _buildListItem extends HookWidget {
  const _buildListItem({this.itemTask});

  final Task itemTask;

  @override
  Widget build(BuildContext context) {
    final databaseModel = useProvider(appDatabaseProvider.state);

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => databaseModel.deleteTask(itemTask),
        )
      ],
      child: CheckboxListTile(
        title: Text(itemTask.name),
        subtitle: Text(itemTask.dueDate?.toString() ?? 'No date'),
        value: itemTask.completed,
        onChanged: (newValue) {
          databaseModel.updateTask(itemTask.copyWith(completed: newValue));
        },
      ),
    );
  }
}

class NewTaskInput extends HookWidget {
  const NewTaskInput();

  @override
  Widget build(BuildContext context) {
    final _databaseModel = useProvider(appDatabaseProvider.state);
    final _controller = useTextEditingController();

    DateTime newTaskDate;
    final _newTaskDate = useState(newTaskDate);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Task Name'),
              onSubmitted: (inputName) {
                final task = Task(
                  name: inputName,
                  dueDate: _newTaskDate.value,
                  completed: null,
                  id: null,
                );
                _databaseModel.insertTask(task);
                _newTaskDate.value = null;
                _controller.clear();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              _newTaskDate.value = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2010),
                lastDate: DateTime(2050),
              );
            },
          ),
        ],
      ),
    );
  }
}
