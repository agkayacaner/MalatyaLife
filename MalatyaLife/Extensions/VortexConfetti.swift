//
//  VortexConfetti.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 31.01.2024.
//

import SwiftUI
import Vortex

struct VortexConfetti: View {
    @Binding var burst: Bool

    var body: some View {
        VortexViewReader { proxy in
            VortexView(.confetti) {
                Rectangle()
                    .fill(.white)
                    .frame(width: 16, height: 16)
                    .tag("square")

                Circle()
                    .fill(.white)
                    .frame(width: 16)
                    .tag("circle")
            }
            .onChange(of: burst) { newValue in
                if newValue {
                    proxy.burst()
                    DispatchQueue.main.async {
                        self.burst = false
                    }
                }
            }
        }
    }
}


#Preview {
    VortexConfetti(burst: Binding<Bool>.constant(true))
}
