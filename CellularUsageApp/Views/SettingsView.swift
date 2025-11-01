//
//  SettingsView.swift
//  CellularUsageApp
//
//  Created by Haja Kiyasudeen on 31/10/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var lowBalanceAlert = true
    @State private var planExpiryReminder = true
    @State private var dataUsageAlert = false
    @State private var promotionalOffers = true

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Notifications Enabled Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(.green)
                                Text("Notifications Enabled")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }

                            Text("You will receive alerts based on your preferences")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.green.opacity(0.1))
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green.opacity(0.3), lineWidth: 1)
                        }
                        .padding(.horizontal)

                        // Notification Preferences Section
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Notification Preferences")
                                    .font(.title2)
                                    .fontWeight(.bold)

                                Text("Manage your notification settings")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            // Low Balance Alert
                            VStack(spacing: 12) {
                                SettingsRowView(
                                    icon: "creditcard.fill",
                                    iconColor: .orange,
                                    title: "Low Balance Alert",
                                    subtitle: "Get notified when your balance is low",
                                    isToggled: $lowBalanceAlert
                                )

                                // Plan Expiry Reminder
                                SettingsRowView(
                                    icon: "calendar.badge.exclamationmark",
                                    iconColor: .red,
                                    title: "Plan Expiry Reminder",
                                    subtitle: "Reminder before your plan expires",
                                    isToggled: $planExpiryReminder
                                )

                                // Data Usage Alert
                                SettingsRowView(
                                    icon: "chart.bar.fill",
                                    iconColor: .blue,
                                    title: "Data Usage Alert",
                                    subtitle: "Alert when data usage reaches 80%",
                                    isToggled: $dataUsageAlert
                                )

                                // Promotional Offers
                                SettingsRowView(
                                    icon: "megaphone.fill",
                                    iconColor: .purple,
                                    title: "Promotional Offers",
                                    subtitle: "Receive updates about special offers",
                                    isToggled: $promotionalOffers
                                )
                            }
                        }
                        .padding(.horizontal)

                        Spacer(minLength: 20)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("BACK") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

struct SettingsRowView: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    @Binding var isToggled: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(iconColor)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Toggle("", isOn: $isToggled)
                .labelsHidden()
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.separator), lineWidth: 0.5)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")

            SettingsView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
