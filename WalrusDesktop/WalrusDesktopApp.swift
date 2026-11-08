//
//  WalrusDesktopApp.swift
//  WalrusDesktop
//
//  Created by Lauren Chen on 9/18/26.
//

import SwiftUI
import SwiftData
import AppKit

@main
struct WalrusDesktopApp: App{
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene{
        Window("WalrusPet", id: "pet"){
            
            PetView()
                .background(Color.clear)
            
        }
        .windowStyle(.hiddenTitleBar)
    }
}
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        DispatchQueue.main.async{
            if let window = NSApplication.shared.windows.first(where: {$0.identifier?.rawValue == "pet"}){
                if let screen = NSScreen.main {
                    window.setFrame(screen.frame, display: true)
                }
                window.backgroundColor = .clear
                window.isOpaque = false
                window.level = NSWindow.Level(
                    rawValue: Int(
                        CGWindowLevelForKey(.desktopWindow))
                )
                window.ignoresMouseEvents = true
                window.hasShadow = false
                window.collectionBehavior = [
                    .canJoinAllSpaces,
                    .stationary
                ]
            }
        }
    }
}
