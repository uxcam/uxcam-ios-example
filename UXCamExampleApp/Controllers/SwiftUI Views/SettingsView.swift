import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section(header: Text("Account")) {
                Toggle("Dark Mode", isOn: .constant(false))
                Toggle("Notifications", isOn: .constant(true))
            }
            
            Section(header: Text("About")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
} 