class Config {
  static const bool isTest = !(bool.fromEnvironment('dart.vm.product'));
}
