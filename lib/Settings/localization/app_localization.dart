import 'package:flutter/material.dart';

class AppLocalizations {
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'setting': 'Setting',
      'name': 'Name',
      'password': 'Password',
      'manage_notifications': 'Manage Notifications',
      'deactivate_account': 'Deactivate Account',
      'support': 'Support',
      'logout': 'Logout',
      'language': 'Language',
      'save_changes': 'Save Changes',
    },
    'ar': {
      'setting': 'الإعدادات',
      'name': 'الاسم',
      'password': 'كلمة المرور',
      'manage_notifications': 'إدارة الإشعارات',
      'deactivate_account': 'إلغاء الحساب',
      'support': 'الدعم',
      'logout': 'تسجيل الخروج',
      'language': 'اللغة',
      'save_changes': 'حفظ التغييرات',
    },
  };

  static String translate(BuildContext context, String key) {
    return _localizedValues[getCurrentLocale(context)]?[key] ?? key;
  }

  static String getCurrentLocale(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }
}
