//
//  SplashView.swift
//  ElonMigo
//
//  Created by Aaron Ma on 5/25/24.
//

import SwiftUI

extension View {
    func splashView<SplashContent: View>(@ViewBuilder splashContent: @escaping () -> SplashContent) -> some View {
        self.modifier(SplashView(splashContent: splashContent))
    }
}

struct SplashView<SplashContent: View>: ViewModifier {
    private let splashContent: () -> SplashContent
    
    @State private var isActive = true
    
    init(@ViewBuilder splashContent: @escaping () -> SplashContent) {
        self.splashContent = splashContent
    }
    
    func body(content: Content) -> some View {
        if isActive {
            splashContent()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            self.isActive = false
                        }
                    }
                }
        } else {
            content
        }
    }
}
