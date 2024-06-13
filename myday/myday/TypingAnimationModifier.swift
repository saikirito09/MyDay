import SwiftUI

struct TypingAnimationModifier: View {
    let text: String
    @State private var displayCharacters = ""
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(displayCharacters)
            .font(.system(size: 50, weight: .bold, design: .default)) // Increased font size to 50
            .onReceive(timer) { _ in
                if displayCharacters.count < text.count {
                    let index = text.index(text.startIndex, offsetBy: displayCharacters.count)
                    displayCharacters.append(text[index])
                }
            }
    }
}
