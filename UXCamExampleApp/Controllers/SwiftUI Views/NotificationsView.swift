import SwiftUI

struct NotificationsView: View {
    var body: some View {
        List {
            ForEach(0..<5) { index in
                NotificationRow(index: index)
            }
        }
        .navigationTitle("Notifications")
    }
}

struct NotificationRow: View {
    let index: Int
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "bell.fill")
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading) {
                Text("Notification \(index + 1)")
                    .font(.headline)
                Text("This is a sample notification message")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("2h ago")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    NotificationsView()
} 