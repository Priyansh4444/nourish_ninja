//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

<<<<<<< HEAD
import geolocator_apple

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
=======
import cloud_firestore
import firebase_auth
import firebase_core
import firebase_database
import geolocator_apple

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FLTFirebaseFirestorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseFirestorePlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FLTFirebaseDatabasePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseDatabasePlugin"))
>>>>>>> 0c9cc78fe756fac836a9674335ff18ec5015756f
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
}
