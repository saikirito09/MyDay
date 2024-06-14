import SwiftUI

struct HeaderView: View {
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<22:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }
    
    var body: some View {
        HStack {
            Text(greeting)
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.title)
        }
        .padding(.top)
    }
}
