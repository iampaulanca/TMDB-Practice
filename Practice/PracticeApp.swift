//
//  PracticeApp.swift
//  Practice
//
//  Created by Paul Ancajima on 11/15/23.
//

import SwiftUI

@main
struct PracticeApp: App {
    @StateObject var userSession = UserSession()
    var body: some Scene {
        WindowGroup {
            ContentView(userSession: userSession)
        }
    }
}
