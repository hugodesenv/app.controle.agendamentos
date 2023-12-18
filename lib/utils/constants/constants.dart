import 'package:flutter/material.dart';

class ColorConstants {
  static const whatsappColor = 0xFF25D366;

  static const secondaryColorHex = '#E91E63';

  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }
}

class RoutesConstants {
  static const routeHome = '/home';
  static const routeLogin = '/login';
  static const routeProfile = '/profile';
  static const routeReport = '/report';
  static const routeSchedule = '/schedule';

  static const routeCustomerQuery = '/customer_query';
  static const routeCustomerNew = '/customer_new';
  static const routeCustomerImport = '/customer_import';
  static const routeCustomerInfo = '/customer_info';

  static const routeItemPage = '/item-page';
  static const routeProdutoNovo = '/item-novo';
}
