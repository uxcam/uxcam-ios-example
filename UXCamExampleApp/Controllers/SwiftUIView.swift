import SwiftUI

struct SwiftUIView: View {
    @Environment(\.dismiss) private var dismiss
    
    struct SwiftUIViewOption: Identifiable {
        let id = UUID()
        let title: String
        let icon: String
        let view: AnyView
    }
    
    let viewOptions: [SwiftUIViewOption] = [
        SwiftUIViewOption(title: "Profile View", icon: "person.circle.fill", view: AnyView(ProfileView())),
        SwiftUIViewOption(title: "Settings View", icon: "gear", view: AnyView(SettingsView())),
        SwiftUIViewOption(title: "Statistics View", icon: "chart.bar.fill", view: AnyView(StatisticsView())),
        SwiftUIViewOption(title: "Notifications View", icon: "bell.fill", view: AnyView(NotificationsView())),
        SwiftUIViewOption(title: "Presentation Modes", icon: "rectangle.split.2x1", view: AnyView(PresentationModesView()))
    ]
    
    var body: some View {
        List(viewOptions) { option in
            NavigationLink(destination: option.view) {
                HStack {
                    Image(systemName: option.icon)
                        .foregroundColor(.blue)
                        .frame(width: 30)
                    Text(option.title)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("SwiftUI Views")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SwiftUIView()
} 
