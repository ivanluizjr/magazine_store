import 'dart:io';

import 'package:magazine_store/app/core/internet_connection/internet_connection_service.dart';

mixin DioServiceMixin {
  Future<void> throwErrorIfNotConnectionWithInternet(
    IInternetConnectionService service,
  ) async {
    final hasConnection = await service.checkConnection();

    if (!hasConnection) {
      throw const HttpException(
        'No internet connection',
      );
    }
  }
}
