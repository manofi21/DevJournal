import 'package:DevJournal/model/task/task_model.dart';
import 'package:DevJournal/view_model/repository/API_repository.dart';
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
      await read(todoRepositoryProvider).addTodo(task);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  Future<void> edit(Task task) async {
    _cacheState();
    state = state.whenData((todos) {
      return [
        for (final todo in todos)
          if (todo.id == task.id) task else todo
      ];
    });

    try {
      await read(todoRepositoryProvider).edit(task);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  Future<void> remove(int id) async {
    _cacheState();
    state = state.whenData(
      (value) => value.where((element) => element.id != id).toList(),
    );
    try {
      await read(todoRepositoryProvider).remove(id);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }
}
