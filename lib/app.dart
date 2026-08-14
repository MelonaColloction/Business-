import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessManagerApp extends StatefulWidget {
  const BusinessManagerApp({super.key});

  @override
  State<BusinessManagerApp> createState() => _BusinessManagerAppState();
}

class _BusinessManagerAppState extends State<BusinessManagerApp> {
  ThemeMode themeMode = ThemeMode.system;
  Locale locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Manager',
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6750A4),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF9C7BFF),
        brightness: Brightness.dark,
      ),
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('fa'),
        Locale('fr'),
        Locale('de'),
        Locale('zh'),
      ],
      home: HomeScreen(
        onThemeChanged: (value) {
          setState(() => themeMode = value);
        },
        onLocaleChanged: (value) {
          setState(() => locale = value);
        },
      ),
    );
  }
}

class AppData {
  static const String key = 'business_manager_data';

  static Future<Map<String, dynamic>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);

    if (raw == null) {
      return {
        'orders': <dynamic>[],
        'appointments': <dynamic>[],
        'income': <dynamic>[],
        'expenses': <dynamic>[],
        'products': <dynamic>[],
        'customers': <dynamic>[],
      };
    }

    final decoded = jsonDecode(raw);

    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    return {
      'orders': <dynamic>[],
      'appointments': <dynamic>[],
      'income': <dynamic>[],
      'expenses': <dynamic>[],
      'products': <dynamic>[],
      'customers': <dynamic>[],
    };
  }

  static Future<void> save(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
  }
}

class HomeScreen extends StatefulWidget {
  final ValueChanged<ThemeMode> onThemeChanged;
  final ValueChanged<Locale> onLocaleChanged;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.onLocaleChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    data = await AppData.load();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _save() async {
    await AppData.save(data);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      DashboardScreen(data: data),
      OrdersScreen(data: data, onChanged: _save),
      AppointmentsScreen(data: data, onChanged: _save),
      FinanceScreen(data: data, onChanged: _save),
      ReportsScreen(data: data),
      ProductsScreen(data: data, onChanged: _save),
      CustomersScreen(data: data, onChanged: _save),
      SettingsScreen(
        onThemeChanged: widget.onThemeChanged,
        onLocaleChanged: widget.onLocaleChanged,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Business Manager',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: NavigationDrawer(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() => index = value);
          Navigator.pop(context);
        },
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(28, 24, 16, 16),
            child: Text(
              'Business Manager',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: Text('Dashboard'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: Text('Orders'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: Text('Appointments'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: Text('Finance'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: Text('Reports'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: Text('Products'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: Text('Customers'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ],
      ),
      body: pages[index],
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DashboardScreen({
    super.key,
    required this.data,
  });

  double _sum(String key) {
    final list = (data[key] as List?) ?? [];

    return list.fold<double>(
      0,
      (sum, item) {
        if (item is Map) {
          return sum + ((item['amount'] as num?)?.toDouble() ?? 0);
        }

        return sum;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final income = _sum('income');
    final expenses = _sum('expenses');
    final profit = income - expenses;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Dashboard',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount:
              MediaQuery.of(context).size.width > 800 ? 4 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            StatCard(
              title: 'Income',
              value: income,
              icon: Icons.arrow_downward,
            ),
            StatCard(
              title: 'Expenses',
              value: expenses,
              icon: Icons.arrow_upward,
            ),
            StatCard(
              title: 'Profit',
              value: profit,
              icon: Icons.trending_up,
            ),
            StatCard(
              title: 'Orders',
              value:
                  ((data['orders'] as List?) ?? []).length.toDouble(),
              icon: Icons.shopping_bag,
              money: false,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Overview',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _row(
                  'Appointments',
                  ((data['appointments'] as List?) ?? []).length,
                ),
                _row(
                  'Customers',
                  ((data['customers'] as List?) ?? []).length,
                ),
                _row(
                  'Products',
                  ((data['products'] as List?) ?? []).length,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _row(String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            '$value',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final bool money;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.money = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 30),
            Text(title),
            Text(
              money
                  ? value.toStringAsFixed(2)
                  : value.toInt().toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final Future<void> Function() onChanged;

  const OrdersScreen({
    super.key,
    required this.data,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final orders = (data['orders'] as List?) ?? [];

    return SimpleManagerPage(
      title: 'Orders',
      icon: Icons.shopping_bag,
      items: orders,
      emptyText: 'No orders yet',
      addLabel: 'Add Order',
      onAdd: () async {
        final result = await showDataDialog(
          context,
          title: 'New Order',
          fields: const [
            'Customer',
            'Amount',
            'Description',
          ],
        );

        if (result == null) {
          return;
        }

        orders.add({
          'customer': result[0],
          'amount': double.tryParse(result[1]) ?? 0,
          'description': result[2],
          'date': DateTime.now().toIso8601String(),
        });

        await onChanged();
      },
    );
  }
}

class AppointmentsScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final Future<void> Function() onChanged;

  const AppointmentsScreen({
    super.key,
    required this.data,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appointments = (data['appointments'] as List?) ?? [];

    return SimpleManagerPage(
      title: 'Appointments',
      icon: Icons.calendar_month,
      items: appointments,
      emptyText: 'No appointments yet',
      addLabel: 'Add Appointment',
      onAdd: () async {
        final result = await showDataDialog(
          context,
          title: 'New Appointment',
          fields: const [
            'Customer',
            'Date & Time',
            'Note',
          ],
        );

        if (result == null) {
          return;
        }

        appointments.add({
          'customer': result[0],
          'date': result[1],
          'note': result[2],
        });

        await onChanged();
      },
    );
  }
}

class FinanceScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final Future<void> Function() onChanged;

  const FinanceScreen({
    super.key,
    required this.data,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Finance',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Income'),
            onTap: () => _add(context, 'income'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.remove_circle_outline),
            title: const Text('Add Expense'),
            onTap: () => _add(context, 'expenses'),
          ),
        ),
      ],
    );
  }

  Future<void> _add(
    BuildContext context,
    String type,
  ) async {
    final result = await showDataDialog(
      context,
      title: type == 'income'
          ? 'Add Income'
          : 'Add Expense',
      fields: const [
        'Title',
        'Amount',
      ],
    );

    if (result == null) {
      return;
    }

    final list = (data[type] as List?) ?? [];

    data[type] = list;

    list.add({
      'title': result[0],
      'amount': double.tryParse(result[1]) ?? 0,
      'date': DateTime.now().toIso8601String(),
    });

    await onChanged();
  }
}

class ReportsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ReportsScreen({
    super.key,
    required this.data,
  });

  double _periodSum(
    String key,
    DateTime now,
    String period,
  ) {
    final list = (data[key] as List?) ?? [];

    return list.fold<double>(
      0,
      (sum, item) {
        if (item is! Map) {
          return sum;
        }

        final date = DateTime.tryParse(
          item['date']?.toString() ?? '',
        );

        if (date == null) {
          return sum;
        }

        bool match;

        if (period == 'day') {
          match = date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        } else if (period == 'month') {
          match =
              date.year == now.year && date.month == now.month;
        } else {
          match = date.year == now.year;
        }

        if (!match) {
          return sum;
        }

        return sum +
            ((item['amount'] as num?)?.toDouble() ?? 0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Reports',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        ReportCard(
          title: 'Today',
          income: _periodSum('income', now, 'day'),
          expenses: _periodSum('expenses', now, 'day'),
        ),
        ReportCard(
          title: 'This Month',
          income: _periodSum('income', now, 'month'),
          expenses: _periodSum('expenses', now, 'month'),
        ),
        ReportCard(
          title: 'This Year',
          income: _periodSum('income', now, 'year'),
          expenses: _periodSum('expenses', now, 'year'),
        ),
      ],
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final double income;
  final double expenses;

  const ReportCard({
    super.key,
    required this.title,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    final profit = income - expenses;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'Income: ${income.toStringAsFixed(2)}',
            ),
            Text(
              'Expenses: ${expenses.toStringAsFixed(2)}',
            ),
            const Divider(),
            Text(
              'Profit: ${profit.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final Future<void> Function() onChanged;

  const ProductsScreen({
    super.key,
    required this.data,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final products = (data['products'] as List?) ?? [];

    return SimpleManagerPage(
      title: 'Products',
      icon: Icons.inventory_2,
      items: products,
      emptyText: 'No products yet',
      addLabel: 'Add Product',
      onAdd: () async {
        final result = await showDataDialog(
          context,
          title: 'New Product',
          fields: const [
            'Name',
            'Price',
            'Stock',
          ],
        );

        if (result == null) {
          return;
        }

        products.add({
          'name': result[0],
          'amount': double.tryParse(result[1]) ?? 0,
          'stock': int.tryParse(result[2]) ?? 0,
        });

        await onChanged();
      },
    );
  }
}

class CustomersScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final Future<void> Function() onChanged;

  const CustomersScreen({
    super.key,
    required this.data,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final customers = (data['customers'] as List?) ?? [];

    return SimpleManagerPage(
      title: 'Customers',
      icon: Icons.people,
      items: customers,
      emptyText: 'No customers yet',
      addLabel: 'Add Customer',
      onAdd: () async {
        final result = await showDataDialog(
          context,
          title: 'New Customer',
          fields: const [
            'Name',
            'Phone',
            'Note',
          ],
        );

        if (result == null) {
          return;
        }

        customers.add({
          'name': result[0],
          'phone': result[1],
          'note': result[2],
        });

        await onChanged();
      },
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final ValueChanged<ThemeMode> onThemeChanged;
  final ValueChanged<Locale> onLocaleChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onLocaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text(
              'English / Persian / French / German / Chinese',
            ),
            onTap: () => _languageDialog(context),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            onTap: () {
              final isDark =
                  Theme.of(context).brightness == Brightness.dark;

              onThemeChanged(
                isDark ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ),
      ],
    );
  }

  void _languageDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Choose Language'),
        children: [
          _language(context, 'English', const Locale('en')),
          _language(context, 'فارسی', const Locale('fa')),
          _language(context, 'Français', const Locale('fr')),
          _language(context, 'Deutsch', const Locale('de')),
          _language(context, '中文', const Locale('zh')),
        ],
      ),
    );
  }

  Widget _language(
    BuildContext context,
    String title,
    Locale locale,
  ) {
    return SimpleDialogOption(
      child: Text(title),
      onPressed: () {
        onLocaleChanged(locale);
        Navigator.pop(context);
      },
    );
  }
}

class SimpleManagerPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final List items;
  final String emptyText;
  final String addLabel;
  final Future<void> Function() onAdd;

  const SimpleManagerPage({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    required this.emptyText,
    required this.addLabel,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 64),
                  const SizedBox(height: 16),
                  Text(emptyText),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () => onAdd(),
                    icon: const Icon(Icons.add),
                    label: Text(addLabel),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final item = items[i];

                if (item is! Map) {
                  return const SizedBox.shrink();
                }

                return Card(
                  child: ListTile(
                    leading: Icon(icon),
                    title: Text(
                      item['name']?.toString() ??
                          item['customer']?.toString() ??
                          item['title']?.toString() ??
                          'Item',
                    ),
                    subtitle: Text(
                      item['description']?.toString() ??
                          item['phone']?.toString() ??
                          item['date']?.toString() ??
                          '',
                    ),
                    trailing: item['amount'] != null
                        ? Text(
                            ((item['amount'] as num?) ?? 0)
                                .toStringAsFixed(2),
                          )
                        : null,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => onAdd(),
        icon: const Icon(Icons.add),
        label: Text(addLabel),
      ),
    );
  }
}

class DataDialogResult {
  static Future<List<String>?> show(
    BuildContext context, {
    required String title,
    required List<String> fields,
  }) {
    return showDialog<List<String>>(
      context: context,
      builder: (_) => _DataDialog(
        title: title,
        fields: fields,
      ),
    );
  }
}

class _DataDialog extends StatefulWidget {
  final String title;
  final List<String> fields;

  const _DataDialog({
    required this.title,
    required this.fields,
  });

  @override
  State<_DataDialog> createState() => _DataDialogState();
}

class _DataDialogState extends State<_DataDialog> {
  late final List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(
      widget.fields.length,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.fields.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: controllers[index],
                decoration: InputDecoration(
                  labelText: widget.fields[index],
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              controllers
                  .map((controller) => controller.text.trim())
                  .toList(),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

Future<List<String>?> showDataDialog(
  BuildContext context, {
  required String title,
  required List<String> fields,
}) {
  return DataDialogResult.show(
    context,
    title: title,
    fields: fields,
  );
}
