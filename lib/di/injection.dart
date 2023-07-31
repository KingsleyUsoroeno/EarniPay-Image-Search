import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

const localhost = Environment('test');
const production = Environment('prod');

@InjectableInit(preferRelativeImports: true, asExtension: true)
void configureDependencies(Environment env) => getIt.init(environment: env.name);

//