enum DatabaseAction { INSERT, UPDATE, DELETE }

extension DabaseActionExtension on DatabaseAction {
  String text() {
    switch (this) {
      case DatabaseAction.INSERT:
        return 'insert';
      case DatabaseAction.UPDATE:
        return 'update';
      case DatabaseAction.DELETE:
        return 'delete';
      default:
        return 'undefined';
    }
  }
}
