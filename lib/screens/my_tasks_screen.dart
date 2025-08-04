import 'package:donezoid/localization/app_localizations.dart';
import 'package:donezoid/models/task_model.dart';
import 'package:donezoid/providers/task_provider.dart';
import 'package:donezoid/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.translate('myTasksTitle')),
          bottom: TabBar(
            tabs: [
              Tab(text: localizations.translate('tasksTabAll')),
              Tab(text: localizations.translate('tasksTabPending')),
              Tab(text: localizations.translate('tasksTabCompleted')),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TaskList(filter: TaskFilter.all),
            _TaskList(filter: TaskFilter.pending),
            _TaskList(filter: TaskFilter.completed),
          ],
        ),
      ),
    );
  }
}

enum TaskFilter { all, pending, completed }

class _TaskList extends StatelessWidget {
  final TaskFilter filter;
  const _TaskList({required this.filter});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final List<Task> tasks;
        switch (filter) {
          case TaskFilter.all:
            tasks = taskProvider.allTasks;
            break;
          case TaskFilter.pending:
            tasks = taskProvider.pendingTasks;
            break;
          case TaskFilter.completed:
            tasks = taskProvider.completedTasks;
            break;
        }

        if (tasks.isEmpty) {
          return const Center(child: Text('No tasks yet!'));
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskCard(task: task);
          },
        );
      },
    );
  }
}
