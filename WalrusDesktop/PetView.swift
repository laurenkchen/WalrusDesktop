//
//  PetView.swift
//  WalrusDesktop
//
//  Created by Lauren Chen on 9/18/26.
//

import SwiftUI
internal import Combine

struct PetView: View {
    @EnvironmentObject var settings: PetSettings
    @State private var position: CGPoint = CGPoint(x:200,y:400)
    @State private var isMovingRight = true
    @State private var isMovingDown = true
    let timer = Timer.publish(every: 1.0/60.0, on: .main, in: .common).autoconnect()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("wal_rus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height:200)
                
                
                if !settings.wisdom.isEmpty {
                    Text(settings.wisdom)
                        .font(.system(size:14))
                        .padding(10)
                        .background(.white, in: RoundedRectangle(cornerRadius:12))
                        .foregroundStyle(.black)
                        .offset(y:-90)
                    
                }
            }
                .position(position)
                .onReceive(timer) { _ in
                    updateMovement(in:geometry.size)
                
            }
            
            .frame(
                width:  geometry.size.width,
                height: geometry.size.height
                )
        }
        .background(Color.clear)
    }
    private func updateMovement(in screenFrame:CGSize) {
        let speed = CGFloat(settings.speed)
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
        if isMovingDown {
            position.y += speed
            if position.y > screenFrame.height - 40 {
                isMovingDown = false
            }
        } else {
            position.y -= speed
            if position.y < 40 {
                isMovingDown = true
            }
        }
    }
}

#Preview {
    PetView()
}
