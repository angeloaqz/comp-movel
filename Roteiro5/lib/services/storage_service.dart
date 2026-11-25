import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String tasksKey = 'tasks';
  static const String lastPageKey = 'last_page';
  static const String formNameKey = 'form_name';
  static const String formEmailKey = 'form_email';
  static const String cartKey = 'cart_items';

  Future<void> saveTasks(List<String> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(tasksKey, tasks);
  }

  Future<List<String>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(tasksKey) ?? [];
  }

  Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tasksKey);
  }

  Future<void> saveLastPage(String page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(lastPageKey, page);
  }

  Future<String> loadLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastPageKey) ?? 'Página A';
  }

  Future<void> saveForm(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(formNameKey, name);
    await prefs.setString(formEmailKey, email);
  }

  Future<Map<String, String>> loadForm() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(formNameKey) ?? '',
      'email': prefs.getString(formEmailKey) ?? '',
    };
  }

  Future<void> saveCart(List<String> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(cartKey, items);
  }

  Future<List<String>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(cartKey) ?? [];
  }
}
