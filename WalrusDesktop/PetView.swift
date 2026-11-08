//
//  PetView.swift
//  WalrusDesktop
//
//  Created by Lauren Chen on 9/18/26.
//

import SwiftUI
internal import Combine

struct PetView: View {
    @State private var position: CGPoint = CGPoint(x:200,y:400)
    @State private var isMovingRight = true
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("BINGUS!")
                    .font(.system(size:60))
                    .position(position)
                    .onReceive(timer) { _ in
                        updateMovement(in:geometry.size)
                    }
            }
            .frame(
                width:  geometry.size.width,
                height: geometry.size.height
                )
        }
        .background(Color.clear)
    }
    private func updateMovement(in screenFrame:CGSize) {
        let speed: CGFloat = 3.0
        if isMovingRight{
            position.x+=speed
            if position.x>screenFrame.width - 40{
                isMovingRight = false
            }
            
        } else {
            position.x -= speed
            if position.x<40{
                isMovingRight = true
            }
        }
    }
}

#Preview {
    PetView()
}
