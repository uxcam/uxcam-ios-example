import SwiftUI

struct StatisticsView: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                StatCard(title: "Total Views", value: "1,234", icon: "eye.fill")
                StatCard(title: "Engagement", value: "89%", icon: "hand.thumbsup.fill")
            }
            
            HStack {
                StatCard(title: "Sessions", value: "45", icon: "clock.fill")
                StatCard(title: "Users", value: "789", icon: "person.2.fill")
            }
        }
        .padding()
        .navigationTitle("Statistics")
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.blue)
            Text(value)
                .font(.title2)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    StatisticsView()
} 