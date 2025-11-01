//
//  SplashScreenView.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isLoading = true
    @State private var scale = 0.8
    @State private var opacity = 0.5
    @State private var rotationAngle = 0.0
    @State private var showPulse = false

    var body: some View {
        ZStack {
            // Clean background that matches dashboard
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            // Subtle animated background circles
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.05))
                    .frame(width: 200, height: 200)
                    .scaleEffect(showPulse ? 1.2 : 0.8)
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: showPulse)

                Circle()
                    .fill(Color.blue.opacity(0.03))
                    .frame(width: 300, height: 300)
                    .scaleEffect(showPulse ? 0.8 : 1.2)
                    .animation(Animation.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: showPulse)
            }

            VStack(spacing: 30) {
                // App Icon/Logo with animation
                ZStack {
                    // Outer ring
                    Circle()
                        .stroke(Color.blue.opacity(0.3), lineWidth: 3)
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(rotationAngle))

                    // Inner circle with icon
                    Circle()
                        .fill(Color(.secondarySystemGroupedBackground))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "antenna.radiowaves.left.and.right")
                                .font(.system(size: 35, weight: .semibold))
                                .foregroundColor(.blue)
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                }
                .scaleEffect(scale)
                .opacity(opacity)

                // App Title
                VStack(spacing: 8) {
                    Text("CellularUsage")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .opacity(opacity)

                    Text("Track Your Usage")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                        .opacity(opacity)
                }

                // Loading indicator
                if isLoading {
                    VStack(spacing: 16) {
                        // Custom loading animation
                        HStack(spacing: 8) {
                            ForEach(0..<3) { index in
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 10, height: 10)
                                    .scaleEffect(showPulse ? 1.0 : 0.5)
                                    .animation(
                                        Animation.easeInOut(duration: 0.6)
                                            .repeatForever()
                                            .delay(Double(index) * 0.2),
                                        value: showPulse
                                    )
                            }
                        }

                        Text("Loading...")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    .opacity(opacity)
                }
            }
        }
        .onAppear {
            // Start animations
            withAnimation(.easeOut(duration: 1.0)) {
                scale = 1.0
                opacity = 1.0
            }

            withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: false)) {
                rotationAngle = 360
            }

            showPulse = true

            // Navigate after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isLoading = false
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}