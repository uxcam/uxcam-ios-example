import SwiftUI

struct PresentationModesView: View {
    @State private var showingBottomSheet = false
    @State private var showingFullScreenCover = false
    @State private var showingSheet = false
    
    var body: some View {
        List {
            Section(header: Text("Presentation Modes")) {
                Button(action: { showingBottomSheet = true }) {
                    HStack {
                        Image(systemName: "rectangle.split.2x1")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text("Bottom Sheet")
                    }
                }
                
                Button(action: { showingSheet = true }) {
                    HStack {
                        Image(systemName: "rectangle.3.group")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text("Sheet")
                    }
                }
                
                Button(action: { showingFullScreenCover = true }) {
                    HStack {
                        Image(systemName: "rectangle.fill")
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text("Full Screen Cover")
                    }
                }
            }
        }
        .navigationTitle("Presentation Modes")
        .sheet(isPresented: $showingSheet) {
            PresentedView(presentationMode: .sheet)
        }
        .sheet(isPresented: $showingBottomSheet) {
            PresentedView(presentationMode: .bottomSheet)
                .presentationDetents([.medium, .large])
        }
        .fullScreenCover(isPresented: $showingFullScreenCover) {
            PresentedView(presentationMode: .fullScreen)
        }
    }
}

enum PresentationMode {
    case sheet
    case bottomSheet
    case fullScreen
}

struct PresentedView: View {
    let presentationMode: PresentationMode
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: presentationModeIcon)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                
                Text(presentationModeTitle)
                    .font(.title)
                
                Text(presentationModeDescription)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            .navigationTitle(presentationModeTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private var presentationModeIcon: String {
        switch presentationMode {
        case .sheet: return "rectangle.3.group"
        case .bottomSheet: return "rectangle.split.2x1"
        case .fullScreen: return "rectangle.fill"
        }
    }
    
    private var presentationModeTitle: String {
        switch presentationMode {
        case .sheet: return "Sheet Presentation"
        case .bottomSheet: return "Bottom Sheet"
        case .fullScreen: return "Full Screen"
        }
    }
    
    private var presentationModeDescription: String {
        switch presentationMode {
        case .sheet:
            return "This view is presented as a sheet that slides up from the bottom and can be dismissed by dragging down."
        case .bottomSheet:
            return "This view is presented as a bottom sheet with detents. You can drag between medium and large sizes."
        case .fullScreen:
            return "This view covers the entire screen and can be dismissed by tapping the Done button."
        }
    }
}

#Preview {
    PresentationModesView()
} 