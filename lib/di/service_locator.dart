import 'package:get_it/get_it.dart';
import 'package:flutter_boilerplate/data/di/data_layer_injection.dart';
import 'package:flutter_boilerplate/domain/di/domain_layer_injection.dart';
import 'package:flutter_boilerplate/presentation/di/presentation_layer_injection.dart';

class ServiceLocator {
  ServiceLocator._();

  static final GetIt getIt = GetIt.instance;

  static Future<void> configure() async {
    await DataLayerInjection.configureDataLayerInjection();
    await DomainLayerInjection.configureDomainLayerInjection();
    await PresentationLayerInjection.configurePresentationLayerInjection();
  }
}
