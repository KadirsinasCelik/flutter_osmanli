import 'package:flutter/material.dart';
import 'package:flutter_osmanli/theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yapılacaklar Listesi',
      home: NotePage(),
    );
  }
}

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Map<String, dynamic>> _items = [];
  final _notingBox = Hive.box('note_box');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  void _refreshItems() {
    final data = _notingBox.keys.map((key) {
      final value = _notingBox.get(key);
      return {"key": key, "name": value["name"], "quantity": value['quantity']};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
    });
  }

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _notingBox.add(newItem);
    _refreshItems();
  }

  Map<String, dynamic> _readItem(int key) {
    final item = _notingBox.get(key);
    return item;
  }

  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _notingBox.put(itemKey, item);
    _refreshItems();
  }

  Future<void> _deleteItem(int itemKey) async {
    await _notingBox.delete(itemKey);
    _refreshItems();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notunuz silindi')));
  }

  void _showForm(BuildContext ctx, int? itemKey) async {
    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _quantityController.text = existingItem['quantity'];
    } else {
      _nameController.text = '';
      _quantityController.text = '';
    }
    showModalBottomSheet(
      backgroundColor: CustomTheme.lightTheme.primaryColor,
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              color: Colors.grey[500],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'Not Başlığı'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Not İçeriği'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (itemKey == null) {
                  _createItem({
                    "name": _nameController.text,
                    "quantity": _quantityController.text,
                  });
                } else {
                  _updateItem(itemKey, {
                    'name': _nameController.text.trim(),
                    'quantity': _quantityController.text.trim(),
                  });
                }

                _nameController.text = '';
                _quantityController.text = '';

                Navigator.of(context).pop();
              },
              child: Text(itemKey == null ? 'Not Ekle' : 'Güncelleme'),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
        backgroundColor: CustomTheme.lightTheme.primaryColor,
        title: const Center(child: Text('Yapılacaklar Listesi')),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'Notunuz Yoktur.',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Card(
                  color: CustomTheme.alternative.primaryColor,
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    title: Text(currentItem['name']),
                    subtitle: Text(currentItem['quantity'].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showForm(context, currentItem['key']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(currentItem['key']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
