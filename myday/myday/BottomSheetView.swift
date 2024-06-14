import SwiftUI

struct BottomSheetView: View {
    @Binding var showBottomSheet: Bool
    @State private var offset = CGSize.zero
    @State private var heightPercentage: CGFloat = 0.6
    @State private var textFieldContent: String = ""
    @State private var mood: String = "" // Add mood state
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                TextField("Write something about your day...", text: $textFieldContent)
                    .font(.system(size: 20)) // Increase font size
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
                
                TextField("Mood", text: $mood) // Add mood text field
                    .font(.system(size: 20))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Spacer()
                    IconButton(action: {
                        // Record action
                    }, imageName: "record.circle", backgroundColor: Color.orange)
                    
                    Spacer()
                    
                    IconButton(action: {
                        showBottomSheet.toggle()
                    }, imageName: "xmark", backgroundColor: Color.red)
                    
                    Spacer()
                    
                    IconButton(action: {
                        addEntry()
                        showBottomSheet.toggle()
                    }, imageName: "checkmark", backgroundColor: Color.green)
                    
                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .frame(width: geometry.size.width, height: geometry.size.height * heightPercentage)
            .background(Color.white)  // Ensure background color is white
            .clipShape(RoundedCorners(radius: 20, corners: [.topLeft, .topRight]))
            .offset(y: geometry.size.height - (geometry.size.height * heightPercentage) + offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                    }
                    .onEnded { _ in
                        if self.offset.height < -50 {
                            self.heightPercentage = min(1.0, self.heightPercentage + 0.2)
                        } else if self.offset.height > 50 {
                            self.heightPercentage = max(0.2, self.heightPercentage - 0.2)
                        }
                        self.offset = .zero
                    }
            )
            .animation(.easeInOut, value: offset)
        }
    }
    
    private func addEntry() {
        let newEntry = JournalEntry(user: navigationModel.username, text: textFieldContent, mood: mood, tags: [], createdAt: Date())
        navigationModel.addEntry(entry: newEntry)
        textFieldContent = ""
        mood = ""
    }
}

struct IconButton: View {
    var action: () -> Void
    var imageName: String
    var backgroundColor: Color
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .font(.title)
                .padding()
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white, lineWidth: 2)
                )
        }
    }
}
