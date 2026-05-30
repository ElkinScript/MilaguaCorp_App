import '../core/env/env.dart';
import 'common_main.dart';

void main() async => commonMain(
      flavor: 'dev',
      baseUrl: EnvDev.baseUrl,
    );
