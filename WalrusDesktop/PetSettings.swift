//
//  PetSettings.swift
//  WalrusDesktop
//
//  Created by Lauren Chen on 11/8/26.
//

import SwiftUI
internal import Combine
class PetSettings: ObservableObject {
    @Published var speed: Double = 3.0
    @Published var wisdom = ""
    let quotes = [
        "hurro",
        ":<",
        "wal rus"
    ]
    func speak () {
        wisdom = quotes.randomElement() ?? "wal rus"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.wisdom = ""
        }
    }
}
