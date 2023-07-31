import 'package:earnipay_image_search/di/injection.dart';
import 'package:injectable/injectable.dart';

enum Environment { prod, test }

abstract class Config {
  Environment get env;
}

@production
@Singleton(as: Config)
class ProdConfig extends Config {
  @override
  Environment env = Environment.prod;
}

@localhost
@Singleton(as: Config)
class LocalHostConfig extends Config {
  @override
  Environment env = Environment.test;
}
