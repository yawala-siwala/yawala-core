/// Shared foundation for the yawala-siwala ecosystem.
///
/// Everything here is consumed via
/// `import 'package:yawala_core/yawala_core.dart';` and covers:
///
/// - **Design system** - `buildYawalaTheme`, `YawalaThemeExtension`,
///   `YawalaSpacing`, `YawalaRadii`, `YawalaDurations`, `YawalaTypography`
/// - **Primitives** - `YawalaLog`, `YawalaEventBus`, `SecureStorage`,
///   `Result`
/// - **Helpers** - duration/byte/date formatters, string utils, bundle ids
library yawala_core;

export 'src/dates.dart';
export 'src/design_tokens.dart';
export 'src/event_bus.dart';
export 'src/ids.dart';
export 'src/logging.dart';
export 'src/result.dart';
export 'src/storage.dart';
export 'src/strings.dart';
export 'src/theme.dart';
