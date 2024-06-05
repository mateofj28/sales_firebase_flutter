import 'package:flutter/material.dart';

class DismissibleSales extends StatelessWidget {
  final String product;
  final String value;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DismissibleSales({
    super.key,
    required this.product,
    required this.value,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onEdit();
        } else if (direction == DismissDirection.startToEnd) {
          print("eliminando...");
          onDelete();
        }
      },
      child: ListTile(
        leading: const Icon(Icons.shop),
        title: Text(product),
        subtitle: Text(value),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
