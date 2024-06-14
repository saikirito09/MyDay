import SwiftUI

struct JournalEntryView: View {
    var date: String
    var day: String
    var mood: String
    var score: String
    var text: String
    
    var color: Color {
        switch mood.lowercased() {
        case "happy":
            return Color(hex: "#A8E6CF")
        case "sad":
            return Color(hex: "#A0D6F5")
        case "angry":
            return Color(hex: "#FF6F61")
        case "calm":
            return Color(hex: "#B3E5FC")
        case "excited":
            return Color(hex: "#FFD700")
        case "bored":
            return Color(hex: "#BDBDBD")
        case "anxious":
            return Color(hex: "#FFF176")
        case "jealous":
            return Color(hex: "#4CAF50")
        case "perplexed":
            return Color(hex: "#BA68C8")
        case "surprised":
            return Color(hex: "#F8BBD0")
        case "tired":
            return Color(hex: "#757575")
        case "fearful":
            return Color(hex: "#1E3A5F")
        default:
            return Color.gray
        }
    }
    
    var emoji: String {
        switch mood.lowercased() {
        case "happy":
            return "😊"
        case "sad":
            return "😢"
        case "angry":
            return "😡"
        case "calm":
            return "😌"
        case "excited":
            return "🤩"
        case "bored":
            return "😐"
        case "anxious":
            return "😟"
        case "jealous":
            return "😒"
        case "perplexed":
            return "😕"
        case "surprised":
            return "😲"
        case "tired":
            return "😴"
        case "fearful":
            return "😨"
        default:
            return "😶"
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Text(date)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(day)
            }
            .frame(width: 60)
            .padding(.vertical)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(emoji) \(mood.uppercased()) • \(score)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                Text(text)
                    .lineLimit(2)
            }
            .padding()
            .background(color)
            .clipShape(RoundedCorners(radius: 20, corners: [.topLeft, .topRight, .bottomLeft]))
        }
        .padding(.horizontal)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1 // skip #
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

