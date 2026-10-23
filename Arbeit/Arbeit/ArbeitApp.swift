//
//  ArbeitApp.swift
//  Arbeit
//
//  Created by Lujain Almulaifi on 23/10/2026.
//

import SwiftUI
import FirebaseCore

/// App delegate used only to configure Firebase when the app launches.
class AppDelegate: NSObject, UIApplicationDelegate {

    /// Called once at launch. Connects the app to Firebase using GoogleService-Info.plist.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ArbeitApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    /// Defines the app's window. Starts at AppView, not ContentView.
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
