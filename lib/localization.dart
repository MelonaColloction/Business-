import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const Map<String, Map<String, String>> _values = {
    'en': {
      'app': 'Business Manager', 'home': 'Home', 'orders': 'Orders',
      'appointments': 'Appointments', 'finance': 'Finance', 'more': 'More',
      'income': 'Income', 'expense': 'Expense', 'profit': 'Profit',
      'contacts': 'Contacts', 'products': 'Products', 'reports': 'Reports',
      'settings': 'Settings', 'add': 'Add', 'save': 'Save', 'cancel': 'Cancel',
      'delete': 'Delete', 'name': 'Name', 'phone': 'Phone', 'amount': 'Amount',
      'category': 'Category', 'note': 'Note', 'customer': 'Customer',
      'supplier': 'Supplier', 'service': 'Service', 'date': 'Date',
      'time': 'Time', 'status': 'Status', 'today': 'Today', 'month': 'Month',
      'year': 'Year', 'all_time': 'All time', 'revenue': 'Revenue',
      'expenses': 'Expenses', 'profit_loss': 'Profit & Loss',
      'language': 'Language', 'theme': 'Theme', 'dark': 'Dark',
      'light': 'Light', 'product': 'Product', 'stock': 'Stock',
      'sell_price': 'Sell price', 'buy_price': 'Buy price',
      'dashboard': 'Dashboard', 'quick_add': 'Quick add',
      'no_data': 'No data yet', 'business': 'Business',
    },
    'fa': {
      'app': 'مدیریت کسب‌وکار', 'home': 'خانه', 'orders': 'سفارش‌ها',
      'appointments': 'نوبت‌ها', 'finance': 'مالی', 'more': 'بیشتر',
      'income': 'درآمد', 'expense': 'هزینه', 'profit': 'سود',
      'contacts': 'مخاطبین', 'products': 'کالاها', 'reports': 'گزارش‌ها',
      'settings': 'تنظیمات', 'add': 'افزودن', 'save': 'ذخیره', 'cancel': 'لغو',
      'delete': 'حذف', 'name': 'نام', 'phone': 'تلفن', 'amount': 'مبلغ',
      'category': 'دسته‌بندی', 'note': 'یادداشت', 'customer': 'مشتری',
      'supplier': 'تأمین‌کننده', 'service': 'خدمت', 'date': 'تاریخ',
      'time': 'زمان', 'status': 'وضعیت', 'today': 'امروز', 'month': 'ماه',
      'year': 'سال', 'all_time': 'کل', 'revenue': 'درآمد',
      'expenses': 'هزینه‌ها', 'profit_loss': 'سود و زیان',
      'language': 'زبان', 'theme': 'پوسته', 'dark': 'تیره',
      'light': 'روشن', 'product': 'کالا', 'stock': 'موجودی',
      'sell_price': 'قیمت فروش', 'buy_price': 'قیمت خرید',
      'dashboard': 'داشبورد', 'quick_add': 'افزودن سریع',
      'no_data': 'هنوز اطلاعاتی وجود ندارد', 'business': 'کسب‌وکار',
    },
    'fr': {
      'app': 'Gestion d’entreprise', 'home': 'Accueil', 'orders': 'Commandes',
      'appointments': 'Rendez-vous', 'finance': 'Finance', 'more': 'Plus',
      'income': 'Revenus', 'expense': 'Dépenses', 'profit': 'Bénéfice',
      'contacts': 'Contacts', 'products': 'Produits', 'reports': 'Rapports',
      'settings': 'Paramètres', 'add': 'Ajouter', 'save': 'Enregistrer',
      'cancel': 'Annuler', 'delete': 'Supprimer', 'name': 'Nom', 'phone': 'Téléphone',
      'amount': 'Montant', 'category': 'Catégorie', 'note': 'Note',
      'customer': 'Client', 'supplier': 'Fournisseur', 'service': 'Service',
      'date': 'Date', 'time': 'Heure', 'status': 'Statut', 'today': 'Aujourd’hui',
      'month': 'Mois', 'year': 'Année', 'all_time': 'Tout', 'revenue': 'Revenus',
      'expenses': 'Dépenses', 'profit_loss': 'Résultat', 'language': 'Langue',
      'theme': 'Thème', 'dark': 'Sombre', 'light': 'Clair', 'product': 'Produit',
      'stock': 'Stock', 'sell_price': 'Prix de vente', 'buy_price': 'Prix d’achat',
      'dashboard': 'Tableau de bord', 'quick_add': 'Ajout rapide',
      'no_data': 'Aucune donnée', 'business': 'Entreprise',
    },
    'de': {
      'app': 'Geschäftsverwaltung', 'home': 'Start', 'orders': 'Bestellungen',
      'appointments': 'Termine', 'finance': 'Finanzen', 'more': 'Mehr',
      'income': 'Einnahmen', 'expense': 'Ausgaben', 'profit': 'Gewinn',
      'contacts': 'Kontakte', 'products': 'Produkte', 'reports': 'Berichte',
      'settings': 'Einstellungen', 'add': 'Hinzufügen', 'save': 'Speichern',
      'cancel': 'Abbrechen', 'delete': 'Löschen', 'name': 'Name', 'phone': 'Telefon',
      'amount': 'Betrag', 'category': 'Kategorie', 'note': 'Notiz',
      'customer': 'Kunde', 'supplier': 'Lieferant', 'service': 'Dienstleistung',
      'date': 'Datum', 'time': 'Zeit', 'status': 'Status', 'today': 'Heute',
      'month': 'Monat', 'year': 'Jahr', 'all_time': 'Gesamt', 'revenue': 'Umsatz',
      'expenses': 'Ausgaben', 'profit_loss': 'Gewinn & Verlust', 'language': 'Sprache',
      'theme': 'Design', 'dark': 'Dunkel', 'light': 'Hell', 'product': 'Produkt',
      'stock': 'Bestand', 'sell_price': 'Verkaufspreis', 'buy_price': 'Einkaufspreis',
      'dashboard': 'Dashboard', 'quick_add': 'Schnell hinzufügen',
      'no_data': 'Noch keine Daten', 'business': 'Unternehmen',
    },
    'zh': {
      'app': '企业管理', 'home': '首页', 'orders': '订单', 'appointments': '预约',
      'finance': '财务', 'more': '更多', 'income': '收入', 'expense': '支出',
      'profit': '利润', 'contacts': '联系人', 'products': '产品', 'reports': '报表',
      'settings': '设置', 'add': '添加', 'save': '保存', 'cancel': '取消',
      'delete': '删除', 'name': '姓名', 'phone': '电话', 'amount': '金额',
      'category': '类别', 'note': '备注', 'customer': '客户', 'supplier': '供应商',
      'service': '服务', 'date': '日期', 'time': '时间', 'status': '状态',
      'today': '今天', 'month': '月份', 'year': '年份', 'all_time': '全部',
      'revenue': '营业收入', 'expenses': '支出', 'profit_loss': '利润与亏损',
      'language': '语言', 'theme': '主题', 'dark': '深色', 'light': '浅色',
      'product': '产品', 'stock': '库存', 'sell_price': '售价', 'buy_price': '进价',
      'dashboard': '仪表盘', 'quick_add': '快速添加', 'no_data': '暂无数据',
      'business': '企业',
    },
  };

  String t(String key) => _values[locale.languageCode]?[key] ??
      _values['en']![key] ?? key;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();
  @override bool isSupported(Locale locale) =>
      ['en', 'fa', 'fr', 'de', 'zh'].contains(locale.languageCode);
  @override Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);
  @override bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
