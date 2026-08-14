import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessManagerApp extends StatefulWidget {
  const BusinessManagerApp({super.key});

  @override
  State<BusinessManagerApp> createState() =>
      _BusinessManagerAppState();
}

class _BusinessManagerAppState extends State<BusinessManagerApp> {
  String languageCode = 'fa';
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      languageCode = prefs.getString('language_code') ?? 'fa';
      darkMode = prefs.getBool('dark_mode') ?? false;
    });
  }

  Future<void> _setLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', code);

    if (!mounted) return;

    setState(() {
      languageCode = code;
    });
  }

  Future<void> _setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);

    if (!mounted) return;

    setState(() {
      darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rtl = languageCode == 'fa';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Manager',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: Directionality(
        textDirection:
            rtl ? TextDirection.rtl : TextDirection.ltr,
        child: HomeScreen(
          languageCode: languageCode,
          darkMode: darkMode,
          onLanguageChanged: _setLanguage,
          onDarkModeChanged: _setDarkMode,
        ),
      ),
    );
  }
}

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: const Color(0xFF6750A4),
    scaffoldBackgroundColor: const Color(0xFFF7F7FA),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: const Color(0xFF9A82DB),
    scaffoldBackgroundColor: const Color(0xFF101014),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

class AppStrings {
  final String code;

  const AppStrings(this.code);

  String get dashboard => tr(
        code,
        'داشبورد',
        'Dashboard',
        'Tableau de bord',
        'Dashboard',
        '仪表板',
      );

  String get orders => tr(
        code,
        'سفارش‌ها',
        'Orders',
        'Commandes',
        'Bestellungen',
        '订单',
      );

  String get appointments => tr(
        code,
        'نوبت‌ها',
        'Appointments',
        'Rendez-vous',
        'Termine',
        '预约',
      );

  String get finance => tr(
        code,
        'مالی',
        'Finance',
        'Finance',
        'Finanzen',
        '财务',
      );

  String get products => tr(
        code,
        'محصولات',
        'Products',
        'Produits',
        'Produkte',
        '产品',
      );

  String get customers => tr(
        code,
        'مشتریان',
        'Customers',
        'Clients',
        'Kunden',
        '客户',
      );

  String get reports => tr(
        code,
        'گزارش‌ها',
        'Reports',
        'Rapports',
        'Berichte',
        '报告',
      );

  String get settings => tr(
        code,
        'تنظیمات',
        'Settings',
        'Paramètres',
        'Einstellungen',
        '设置',
      );

  String get income => tr(
        code,
        'درآمد',
        'Income',
        'Revenus',
        'Einnahmen',
        '收入',
      );

  String get expenses => tr(
        code,
        'هزینه‌ها',
        'Expenses',
        'Dépenses',
        'Ausgaben',
        '支出',
      );

  String get profit => tr(
        code,
        'سود خالص',
        'Net Profit',
        'Bénéfice net',
        'Nettogewinn',
        '净利润',
      );

  String get language => tr(
        code,
        'زبان',
        'Language',
        'Langue',
        'Sprache',
        '语言',
      );

  String get darkMode => tr(
        code,
        'حالت تاریک',
        'Dark Mode',
        'Mode sombre',
        'Dunkelmodus',
        '深色模式',
      );

  String get add => tr(
        code,
        'افزودن',
        'Add',
        'Ajouter',
        'Hinzufügen',
        '添加',
      );

  String get save => tr(
        code,
        'ذخیره',
        'Save',
        'Enregistrer',
        'Speichern',
        '保存',
      );

  String get cancel => tr(
        code,
        'لغو',
        'Cancel',
        'Annuler',
        'Abbrechen',
        '取消',
      );

  String get delete => tr(
        code,
        'حذف',
        'Delete',
        'Supprimer',
        'Löschen',
        '删除',
      );

  String get confirmDelete => tr(
        code,
        'آیا مطمئن هستید که می‌خواهید این مورد را حذف کنید؟',
        'Are you sure you want to delete this item?',
        'Voulez-vous vraiment supprimer cet élément ?',
        'Möchten Sie diesen Eintrag wirklich löschen?',
        '确定要删除此项目吗？',
      );

  String get noData => tr(
        code,
        'اطلاعاتی وجود ندارد',
        'No data available',
        'Aucune donnée',
        'Keine Daten',
        '暂无数据',
      );

  String get name => tr(
        code,
        'نام',
        'Name',
        'Nom',
        'Name',
        '名称',
      );

  String get customerName => tr(
        code,
        'نام مشتری',
        'Customer name',
        'Nom du client',
        'Kundenname',
        '客户姓名',
      );

  String get description => tr(
        code,
        'توضیحات',
        'Description',
        'Description',
        'Beschreibung',
        '描述',
      );

  String get amount => tr(
        code,
        'مبلغ',
        'Amount',
        'Montant',
        'Betrag',
        '金额',
      );

  String get price => tr(
        code,
        'قیمت',
        'Price',
        'Prix',
        'Preis',
        '价格',
      );

  String get stock => tr(
        code,
        'موجودی',
        'Stock',
        'Stock',
        'Bestand',
        '库存',
      );

  String get phone => tr(
        code,
        'شماره تماس',
        'Phone',
        'Téléphone',
        'Telefon',
        '电话',
      );

  String get note => tr(
        code,
        'یادداشت',
        'Note',
        'Note',
        'Notiz',
        '备注',
      );

  String get today => tr(
        code,
        'امروز',
        'Today',
        "Aujourd'hui",
        'Heute',
        '今天',
      );

  String get thisMonth => tr(
        code,
        'این ماه',
        'This month',
        'Ce mois',
        'Diesen Monat',
        '本月',
      );

  String get thisYear => tr(
        code,
        'امسال',
        'This year',
        'Cette année',
        'Dieses Jahr',
        '今年',
      );

  String get all => tr(
        code,
        'کل',
        'All time',
        'Total',
        'Gesamt',
        '全部',
      );
}

String tr(
  String code,
  String fa,
  String en,
  String fr,
  String de,
  String zh,
) {
  switch (code) {
    case 'en':
      return en;
    case 'fr':
      return fr;
    case 'de':
      return de;
    case 'zh':
      return zh;
    case 'fa':
    default:
      return fa;
  }
}

class BusinessData {
  List<OrderModel> orders;
  List<AppointmentModel> appointments;
  List<FinanceModel> incomes;
  List<FinanceModel> expenses;
  List<ProductModel> products;
  List<CustomerModel> customers;

  BusinessData({
    List<OrderModel>? orders,
    List<AppointmentModel>? appointments,
    List<FinanceModel>? incomes,
    List<FinanceModel>? expenses,
    List<ProductModel>? products,
    List<CustomerModel>? customers,
  })  : orders = orders ?? [],
        appointments = appointments ?? [],
        incomes = incomes ?? [],
        expenses = expenses ?? [],
        products = products ?? [],
        customers = customers ?? [];

  double get totalIncome {
    return incomes.fold(
      0,
      (sum, item) => sum + item.amount,
    );
  }

  double get totalExpenses {
    return expenses.fold(
      0,
      (sum, item) => sum + item.amount,
    );
  }

  double get profit {
    return totalIncome - totalExpenses;
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders.map((e) => e.toJson()).toList(),
      'appointments':
          appointments.map((e) => e.toJson()).toList(),
      'incomes':
          incomes.map((e) => e.toJson()).toList(),
      'expenses':
          expenses.map((e) => e.toJson()).toList(),
      'products':
          products.map((e) => e.toJson()).toList(),
      'customers':
          customers.map((e) => e.toJson()).toList(),
    };
  }

  factory BusinessData.fromJson(
    Map<String, dynamic> json,
  ) {
    return BusinessData(
      orders: parseList<OrderModel>(
        json['orders'],
        OrderModel.fromJson,
      ),
      appointments: parseList<AppointmentModel>(
        json['appointments'],
        AppointmentModel.fromJson,
      ),
      incomes: parseList<FinanceModel>(
        json['incomes'],
        FinanceModel.fromJson,
      ),
      expenses: parseList<FinanceModel>(
        json['expenses'],
        FinanceModel.fromJson,
      ),
      products: parseList<ProductModel>(
        json['products'],
        ProductModel.fromJson,
      ),
      customers: parseList<CustomerModel>(
        json['customers'],
        CustomerModel.fromJson,
      ),
    );
  }
}

List<T> parseList<T>(
  dynamic value,
  T Function(Map<String, dynamic>) parser,
) {
  if (value is! List) {
    return <T>[];
  }

  return value
      .whereType<Map>()
      .map(
        (item) => parser(
          Map<String, dynamic>.from(item),
        ),
      )
      .toList();
}

class OrderModel {
  String id;
  String customer;
  String description;
  double amount;
  DateTime date;

  OrderModel({
    required this.id,
    required this.customer,
    required this.description,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory OrderModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return OrderModel(
      id: json['id'] ?? '',
      customer: json['customer'] ?? '',
      description: json['description'] ?? '',
      amount:
          (json['amount'] as num?)?.toDouble() ?? 0,
      date: DateTime.tryParse(
            json['date'] ?? '',
          ) ??
          DateTime.now(),
    );
  }
}

class AppointmentModel {
  String id;
  String customer;
  String description;
  DateTime date;

  AppointmentModel({
    required this.id,
    required this.customer,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  factory AppointmentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AppointmentModel(
      id: json['id'] ?? '',
      customer: json['customer'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.tryParse(
            json['date'] ?? '',
          ) ??
          DateTime.now(),
    );
  }
}

class FinanceModel {
  String id;
  String title;
  double amount;
  DateTime date;

  FinanceModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory FinanceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return FinanceModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      amount:
          (json['amount'] as num?)?.toDouble() ?? 0,
      date: DateTime.tryParse(
            json['date'] ?? '',
          ) ??
          DateTime.now(),
    );
  }
}

class ProductModel {
  String id;
  String name;
  double price;
  int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
    };
  }

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price:
          (json['price'] as num?)?.toDouble() ?? 0,
      stock:
          (json['stock'] as num?)?.toInt() ?? 0,
    );
  }
}

class CustomerModel {
  String id;
  String name;
  String phone;
  String note;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'note': note,
    };
  }

  factory CustomerModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CustomerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      note: json['note'] ?? '',
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String languageCode;
  final bool darkMode;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<bool> onDarkModeChanged;

  const HomeScreen({
    super.key,
    required this.languageCode,
    required this.darkMode,
    required this.onLanguageChanged,
    required this.onDarkModeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BusinessData data = BusinessData();

  int selectedIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadBusinessData();
  }

  Future<void> _loadBusinessData() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('business_data');

    if (raw != null) {
      try {
        final decoded =
            jsonDecode(raw) as Map<String, dynamic>;

        final loaded =
            BusinessData.fromJson(decoded);

        data.orders = loaded.orders;
        data.appointments = loaded.appointments;
        data.incomes = loaded.incomes;
        data.expenses = loaded.expenses;
        data.products = loaded.products;
        data.customers = loaded.customers;
      } catch (_) {}
    }

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  Future<void> _saveBusinessData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'business_data',
      jsonEncode(data.toJson()),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings(widget.languageCode);

    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final pages = [
      DashboardPage(
        data: data,
        strings: strings,
      ),
      OrdersPage(
        data: data,
        onSave: _saveBusinessData,
        strings: strings,
      ),
      AppointmentsPage(
        data: data,
        onSave: _saveBusinessData,
        strings: strings,
      ),
      FinancePage(
        data: data,
        onSave: _saveBusinessData,
        strings: strings,
      ),
      ProductsPage(
        data: data,
        onSave: _saveBusinessData,
        strings: strings,
      ),
      CustomersPage(
        data: data,
        onSave: _saveBusinessData,
        strings: strings,
      ),
      ReportsPage(
        data: data,
        strings: strings,
      ),
      SettingsPage(
        languageCode: widget.languageCode,
        darkMode: widget.darkMode,
        onLanguageChanged:
            widget.onLanguageChanged,
        onDarkModeChanged:
            widget.onDarkModeChanged,
        strings: strings,
      ),
    ];

    final labels = [
      strings.dashboard,
      strings.orders,
      strings.appointments,
      strings.finance,
      strings.products,
      strings.customers,
      strings.reports,
      strings.settings,
    ];

    final icons = [
      Icons.dashboard_outlined,
      Icons.receipt_long_outlined,
      Icons.calendar_month_outlined,
      Icons.account_balance_wallet_outlined,
      Icons.inventory_2_outlined,
      Icons.people_outline,
      Icons.bar_chart_outlined,
      Icons.settings_outlined,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels[selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });

          Navigator.pop(context);
        },
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              'Business Manager',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < labels.length; i++)
            NavigationDrawerDestination(
              icon: Icon(icons[i]),
              label: Text(labels[i]),
            ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex:
            selectedIndex > 3 ? 0 : selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(icons[0]),
            label: labels[0],
          ),
          NavigationDestination(
            icon: Icon(icons[1]),
            label: labels[1],
          ),
          NavigationDestination(
            icon: Icon(icons[2]),
            label: labels[2],
          ),
          NavigationDestination(
            icon: Icon(icons[3]),
            label: labels[3],
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final BusinessData data;
  final AppStrings strings;

  const DashboardPage({
    super.key,
    required this.data,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          strings.dashboard,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount:
              MediaQuery.of(context).size.width >= 700
                  ? 4
                  : 2,
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: [
            StatCard(
              title: strings.income,
              value: money(data.totalIncome),
              icon: Icons.trending_up,
            ),
            StatCard(
              title: strings.expenses,
              value: money(data.totalExpenses),
              icon: Icons.trending_down,
            ),
            StatCard(
              title: strings.profit,
              value: money(data.profit),
              icon: Icons.account_balance,
            ),
            StatCard(
              title: strings.orders,
              value: data.orders.length.toString(),
              icon: Icons.receipt_long,
            ),
          ],
        ),
      ],
    );
  }
}

class OrdersPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;
  final AppStrings strings;

  const OrdersPage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: strings.orders,
      emptyText: strings.noData,
      icon: Icons.receipt_long,
      items: [
        for (final order in data.orders)
          ListItemData(
            id: order.id,
            title: order.customer,
            subtitle: order.description,
            trailing: money(order.amount),
          ),
      ],
      onAdd: () async {
        final result = await formDialog(
          context,
          strings.add,
          [
            strings.customerName,
            strings.description,
            strings.amount,
          ],
        );

        if (result == null) return;

        data.orders.insert(
          0,
          OrderModel(
            id: generateId(),
            customer: result[0],
            description: result[1],
            amount:
                double.tryParse(result[2]) ?? 0,
            date: DateTime.now(),
          ),
        );

        await onSave();
      },
      onDelete: (id) async {
        data.orders.removeWhere(
          (item) => item.id == id,
        );
        await onSave();
      },
    );
  }
}

class AppointmentsPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;
  final AppStrings strings;

  const AppointmentsPage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: strings.appointments,
      emptyText: strings.noData,
      icon: Icons.calendar_month,
      items: [
        for (final appointment in data.appointments)
          ListItemData(
            id: appointment.id,
            title: appointment.customer,
            subtitle: appointment.description,
            trailing:
                formatDate(appointment.date),
          ),
      ],
      onAdd: () async {
        final result = await formDialog(
          context,
          strings.add,
          [
            strings.customerName,
            strings.description,
          ],
        );

        if (result == null) return;

        data.appointments.insert(
          0,
          AppointmentModel(
            id: generateId(),
            customer: result[0],
            description: result[1],
            date: DateTime.now(),
          ),
        );

        await onSave();
      },
      onDelete: (id) async {
        data.appointments.removeWhere(
          (item) => item.id == id,
        );
        await onSave();
      },
    );
  }
}

class FinancePage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;
  final AppStrings strings;

  const FinancePage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final entries = [
      ...data.incomes.map(
        (item) => FinanceListItem(
          id: item.id,
          title: item.title,
          amount: item.amount,
          income: true,
        ),
      ),
      ...data.expenses.map(
        (item) => FinanceListItem(
          id: item.id,
          title: item.title,
          amount: item.amount,
          income: false,
        ),
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        StatCard(
          title: strings.income,
          value: money(data.totalIncome),
          icon: Icons.trending_up,
        ),
        StatCard(
          title: strings.expenses,
          value: money(data.totalExpenses),
          icon: Icons.trending_down,
        ),
        StatCard(
          title: strings.profit,
          value: money(data.profit),
          icon: Icons.account_balance,
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: () => addFinance(
            context,
            true,
          ),
          icon: const Icon(Icons.add),
          label: Text(strings.income),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () => addFinance(
            context,
            false,
          ),
          icon: const Icon(Icons.remove),
          label: Text(strings.expenses),
        ),
        const SizedBox(height: 20),
        for (final entry in entries)
          Dismissible(
            key: ValueKey(entry.id),
            direction:
                DismissDirection.endToStart,
            confirmDismiss: (_) =>
                confirmDelete(
              context,
              strings,
            ),
            onDismissed: (_) async {
              if (entry.income) {
                data.incomes.removeWhere(
                  (item) => item.id == entry.id,
                );
              } else {
                data.expenses.removeWhere(
                  (item) => item.id == entry.id,
                );
              }

              await onSave();
            },
            background: deleteBackground(),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    entry.income
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                  ),
                ),
                title: Text(entry.title),
                trailing: Text(
                  money(entry.amount),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> addFinance(
    BuildContext context,
    bool income,
  ) async {
    final result = await formDialog(
      context,
      income ? strings.income : strings.expenses,
      [
        strings.name,
        strings.amount,
      ],
    );

    if (result == null) return;

    final item = FinanceModel(
      id: generateId(),
      title: result[0],
      amount:
          double.tryParse(result[1]) ?? 0,
      date: DateTime.now(),
    );

    if (income) {
      data.incomes.insert(0, item);
    } else {
      data.expenses.insert(0, item);
    }

    await onSave();
  }
}

class ProductsPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;
  final AppStrings strings;

  const ProductsPage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: strings.products,
      emptyText: strings.noData,
      icon: Icons.inventory_2,
      items: [
        for (final product in data.products)
          ListItemData(
            id: product.id,
            title: product.name,
            subtitle:
                '${strings.stock}: ${product.stock}',
            trailing: money(product.price),
          ),
      ],
      onAdd: () async {
        final result = await formDialog(
          context,
          strings.add,
          [
            strings.name,
            strings.price,
            strings.stock,
          ],
        );

        if (result == null) return;

        data.products.insert(
          0,
          ProductModel(
            id: generateId(),
            name: result[0],
            price:
                double.tryParse(result[1]) ?? 0,
            stock:
                int.tryParse(result[2]) ?? 0,
          ),
        );

        await onSave();
      },
      onDelete: (id) async {
        data.products.removeWhere(
          (item) => item.id == id,
        );
        await onSave();
      },
    );
  }
}

class CustomersPage extends StatelessWidget {
  final BusinessData data;
  final Future<void> Function() onSave;
  final AppStrings strings;

  const CustomersPage({
    super.key,
    required this.data,
    required this.onSave,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return DataListPage(
      title: strings.customers,
      emptyText: strings.noData,
      icon: Icons.people,
      items: [
        for (final customer in data.customers)
          ListItemData(
            id: customer.id,
            title: customer.name,
            subtitle: customer.phone,
            trailing: '',
          ),
      ],
      onAdd: () async {
        final result = await formDialog(
          context,
          strings.add,
          [
            strings.name,
            strings.phone,
            strings.note,
          ],
        );

        if (result == null) return;

        data.customers.insert(
          0,
          CustomerModel(
            id: generateId(),
            name: result[0],
            phone: result[1],
            note: result[2],
          ),
        );

        await onSave();
      },
      onDelete: (id) async {
        data.customers.removeWhere(
          (item) => item.id == id,
        );
        await onSave();
      },
    );
  }
}

class ReportsPage extends StatelessWidget {
  final BusinessData data;
  final AppStrings strings;

  const ReportsPage({
    super.key,
    required this.data,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        ReportCard(
          title: strings.today,
          income:
              periodTotal(data.incomes, now, 0),
          expenses:
              periodTotal(data.expenses, now, 0),
        ),
        ReportCard(
          title: strings.thisMonth,
          income:
              periodTotal(data.incomes, now, 1),
          expenses:
              periodTotal(data.expenses, now, 1),
        ),
        ReportCard(
          title: strings.thisYear,
          income:
              periodTotal(data.incomes, now, 2),
          expenses:
              periodTotal(data.expenses, now, 2),
        ),
        ReportCard(
          title: strings.all,
          income: data.totalIncome,
          expenses: data.totalExpenses,
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  final String languageCode;
  final bool darkMode;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<bool> onDarkModeChanged;
  final AppStrings strings;

  const SettingsPage({
    super.key,
    required this.languageCode,
    required this.darkMode,
    required this.onLanguageChanged,
    required this.onDarkModeChanged,
    required this.strings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Card(
          child: ListTile(
            leading:
                const Icon(Icons.language),
            title: Text(strings.language),
            subtitle:
                Text(languageName(languageCode)),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title:
                        Text(strings.language),
                    children: [
                      for (final code in [
                        'fa',
                        'en',
                        'fr',
                        'de',
                        'zh',
                      ])
                        SimpleDialogOption(
                          onPressed: () {
                            onLanguageChanged(code);
                            Navigator.pop(context);
                          },
                          child:
                              Text(languageName(code)),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        Card(
          child: SwitchListTile(
            secondary:
                const Icon(Icons.dark_mode),
            title: Text(strings.darkMode),
            value: darkMode,
            onChanged: onDarkModeChanged,
          ),
        ),
      ],
    );
  }
}

class DataListPage extends StatelessWidget {
  final String title;
  final String emptyText;
  final IconData icon;
  final List<ListItemData> items;
  final Future<void> Function() onAdd;
  final Future<void> Function(String id) onDelete;

  const DataListPage({
    super.key,
    required this.title,
    required this.emptyText,
    required this.icon,
    required this.items,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(icon, size: 70),
            const SizedBox(height: 15),
            Text(emptyText),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: Text(title),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding:
                const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment:
                  AlignmentDirectional.centerStart,
              child: FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: Text(title),
              ),
            ),
          );
        }

        final item = items[index - 1];

        return Dismissible(
          key: ValueKey(item.id),
          direction:
              DismissDirection.endToStart,
          confirmDismiss: (_) =>
              confirmDelete(context, null),
          onDismissed: (_) {
            onDelete(item.id);
          },
          background: deleteBackground(),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(icon),
              ),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.trailing.isNotEmpty)
                    Text(
                      item.trailing,
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  IconButton(
                    tooltip: 'حذف',
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final confirmed =
                          await confirmDelete(
                        context,
                        null,
                      );

                      if (confirmed) {
                        await onDelete(item.id);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListItemData {
  final String id;
  final String title;
  final String subtitle;
  final String trailing;

  const ListItemData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });
}

class FinanceListItem {
  final String id;
  final String title;
  final double amount;
  final bool income;

  const FinanceListItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.income,
  });
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 28),
            Text(title),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            InfoRow(
              icon: Icons.arrow_upward,
              title: 'درآمد',
              value: money(income),
            ),
            InfoRow(
              icon: Icons.arrow_downward,
              title: 'هزینه',
              value: money(expenses),
            ),
            const Divider(),
            InfoRow(
              icon: Icons.account_balance,
              title: 'سود خالص',
              value:
                  money(income - expenses),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> confirmDelete(
  BuildContext context,
  AppStrings? strings,
) async {
  final title = strings?.delete ?? 'حذف اطلاعات';
  final message = strings?.confirmDelete ??
      'آیا مطمئن هستید که می‌خواهید این مورد را حذف کنید؟';
  final cancel = strings?.cancel ?? 'لغو';
  final delete = strings?.delete ?? 'حذف';

  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(cancel),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(delete),
              ),
            ],
          );
        },
      ) ??
      false;
}

Widget deleteBackground() {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    alignment: Alignment.centerRight,
    padding:
        const EdgeInsets.symmetric(horizontal: 24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.red,
    ),
    child: const Icon(
      Icons.delete,
      color: Colors.white,
    ),
  );
}

Future<List<String>?> formDialog(
  BuildContext context,
  String title,
  List<String> fields,
) async {
  final controllers =
      <TextEditingController>[];

  for (int i = 0; i < fields.length; i++) {
    controllers.add(TextEditingController());
  }

  final result =
      await showDialog<List<String>>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0;
                  i < fields.length;
                  i++)
                Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: TextField(
                    controller:
                        controllers[i],
                    decoration:
                        InputDecoration(
                      labelText: fields[i],
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('لغو'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(
                context,
                controllers
                    .map(
                      (controller) =>
                          controller.text.trim(),
                    )
                    .toList(),
              );
            },
            child: const Text('ذخیره'),
          ),
        ],
      );
    },
  );

  for (final controller in controllers) {
    controller.dispose();
  }

  return result;
}

double periodTotal(
  List<FinanceModel> list,
  DateTime now,
  int type,
) {
  double total = 0;

  for (final item in list) {
    bool matches = false;

    if (type == 0) {
      matches =
          item.date.year == now.year &&
          item.date.month == now.month &&
          item.date.day == now.day;
    } else if (type == 1) {
      matches =
          item.date.year == now.year &&
          item.date.month == now.month;
    } else if (type == 2) {
      matches =
          item.date.year == now.year;
    }

    if (matches) {
      total += item.amount;
    }
  }

  return total;
}

String money(double value) {
  return value.toStringAsFixed(0);
}

String generateId() {
  return DateTime.now()
      .microsecondsSinceEpoch
      .toString();
}

String formatDate(DateTime date) {
  final day =
      date.day.toString().padLeft(2, '0');
  final month =
      date.month.toString().padLeft(2, '0');
  final hour =
      date.hour.toString().padLeft(2, '0');
  final minute =
      date.minute.toString().padLeft(2, '0');

  return '$day/$month $hour:$minute';
}

String languageName(String code) {
  switch (code) {
    case 'en':
      return 'English';
    case 'fr':
      return 'Français';
    case 'de':
      return 'Deutsch';
    case 'zh':
      return '中文';
    case 'fa':
    default:
      return 'فارسی';
  }
}
