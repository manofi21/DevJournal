import 'package:DevJournal/model/task/task_model.dart';
import 'package:DevJournal/view/home_page.dart';
import 'package:DevJournal/view/status_dialog.dart';
import 'package:DevJournal/view_model/repository/API_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentTodo = ScopedProvider<Task>(null);

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  throw UnimplementedError();
});

final todosNotifierProvider = StateNotifierProvider<TodoNotifier>((ref) {
  return TodoNotifier(ref.read);
});

final todoExceptionProvider = StateProvider<TodoException>((ref) {
  return null;
});

void awaitStatus(Map<String, dynamic> map) async {
  return Future.delayed(Duration(milliseconds: 500), () {
    showDialogClass(map);
  });
}

class TodoNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  TodoNotifier(
    this.read, [
    AsyncValue<List<Task>> todos,
  ]) : super(todos ?? const AsyncValue.loading()) {
    _retrieveTodos();
  }

  final Reader read;
  AsyncValue<List<Task>> previousState;
  void _resetState() {
    if (previousState != null) {
      state = previousState;
      previousState = null;
    }
  }

  void _handleException(TodoException e) {
    _resetState();
    read(todoExceptionProvider).state = e;
  }

  void _cacheState() {
    previousState = state;
  }

  Future<void> _retrieveTodos() async {
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos();
      state = AsyncValue.data(todos);
    } on TodoException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> retryLoadingTodo() async {
    state = const AsyncValue.loading();
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos();
      state = AsyncValue.data(todos);
    } on TodoException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(Task task) async {
    _cacheState();
    state = state.whenData((todos) => [...todos]..add(task));

    try {
      showDialogClass();
      await read(todoRepositoryProvider).addTodo(task);
      Navigator.pop(scaffoldKey.currentContext);
      awaitStatus({"Success": "Data Has Been Added"});
    } on TodoException catch (e) {
      Navigator.pop(scaffoldKey.currentContext);
      awaitStatus({"Error": e.toString()});
      _handleException(e);
    }
  }

  Future<void> edit(int id, Task newTask) async {
    _cacheState();
// error
    try {
      showDialogClass();
      await read(todoRepositoryProvider).edit(id, newTask);
      Navigator.pop(scaffoldKey.currentContext);
      awaitStatus({"Success": "Data Has Been Edited"});
    } on TodoException catch (e) {
      Navigator.pop(scaffoldKey.currentContext);
      awaitStatus({"Error": e.toString()});
      _handleException(e);
    }
  }

  Future<void> remove(int id, Task task) async {
    //error
    _cacheState();
    state = state.whenData(
      (value) => value.where((element) => element != task).toList(),
    );
    try {
      showDialogClass();
      await read(todoRepositoryProvider).remove(id, task);
      Navigator.pop(scaffoldKey.currentContext);
      awaitStatus({"Success": "Data Has Been Deleted"});
    } on TodoException catch (e) {
      Navigator.pop(scaffoldKey.currentContext);
      awaitStatus({"Error": e.toString()});
      _handleException(e);
    }
  }
}
