import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text("John Doe")
                .font(.title)
                .padding(.top)
            
            Text("iOS Developer")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
} 