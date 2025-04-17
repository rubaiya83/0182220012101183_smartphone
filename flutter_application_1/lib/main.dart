import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Daily Expense Tracker',
      debugShowCheckedModeBanner: false,
      home: ExpensePage(),
    );
  }
}

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final List<Map<String, String>> _expenses = [
    {'title': 'Groceries', 'amount': '৳250'},
    {'title': 'Vegetable', 'amount': '৳100'},
    {'title': 'Transport', 'amount': '৳140'},
  ];

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void showAddDialog(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  hintText: "e.g. Snacks",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount (৳)",
                  hintText: "e.g. 120",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String title = titleController.text.trim();
                String amount = amountController.text.trim();

                if (title.isNotEmpty && amount.isNotEmpty) {
                  setState(() {
                    _expenses.add({'title': title, 'amount': '৳$amount'});
                  });
                  Navigator.pop(context);
                  showSnackBar(context, "Expense added!");
                } else {
                  showSnackBar(context, "Please fill all fields");
                }
              },
              child: const Text("Add"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Expenses"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () => showSnackBar(context, "Settings Clicked"),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Center(
                child: Text(
                  "Expense Tracker",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => showSnackBar(context, "Home Clicked"),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () => showSnackBar(context, "About Clicked"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Today's Expenses",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text(expense['title']!),
                      trailing: Text(
                        expense['amount']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => showAddDialog(context),
              icon: const Icon(Icons.add),
              label: const Text("Add Expense"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
