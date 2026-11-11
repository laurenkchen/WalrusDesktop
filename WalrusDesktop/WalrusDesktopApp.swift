//
//  WalrusDesktopApp.swift
//  WalrusDesktop
//
//  Created by Lauren Chen on 9/18/26.
//

import SwiftUI
import SwiftData
import AppKit


struct OpenSettingsOnLaunch: View {
    @Environment(\.openWindow) private var openWindow
    var body: some View {
        Color.clear
            .frame(width: 0, height:0)
            .task{
                openWindow(id: "settings")
            }
    }
}
@main
struct WalrusDesktopApp: App{
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var settings = PetSettings()

    
    var body: some Scene{
        Window("WalrusPet", id: "pet"){
            
            PetView()
                .background(Color.clear)
                .environmentObject(settings)
                .background{
                    OpenSettingsOnLaunch()
                }
        }
        .windowStyle(.hiddenTitleBar)
        
        Window("wal rus", id: "settings"){
        VStack(spacing:20) {
            Text("settings")
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .onDisappear{
                    NSApplication.shared.terminate(nil)
                }
            Image("wal_rus")
                .resizable()
                .scaledToFit()
                .frame(width:160, height:160)
            
            Text("Speed: \(settings.speed, specifier: "%.1f")")
            
            Slider(
                value: $settings.speed,
                in: 0...50,
                
            )
            .tint(.black)
            Button("wisdom!"){
                settings.speak()
            }
        }
                .padding(25)
                .frame(width:320)
                
            }
        .defaultSize(width: 300, height:350)
    }
}
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        DispatchQueue.main.async{
            if let window = NSApplication.shared.windows.first(where: {$0.identifier?.rawValue == "pet"}){
                window.styleMask = [.borderless]
                if let screen = window.screen ?? NSScreen.main {
                    window.setFrame(screen.frame, display:true)
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
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
