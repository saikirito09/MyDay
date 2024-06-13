import SwiftUI

struct HomeView: View {
    @State private var selectedMonth: String = "This month"
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView()
            MonthSelectorView(selectedMonth: $selectedMonth)
            JournalEntriesView(selectedMonth: selectedMonth)
            Spacer()
        }
        .padding()
    }
}

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

struct MonthSelectorView: View {
    @Binding var selectedMonth: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(months, id: \.self) { month in
                    Text(month)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(month == selectedMonth ? Color.gray.opacity(0.2) : Color.clear)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .foregroundColor(month == selectedMonth ? .black : .gray)
                        .font(month == selectedMonth ? .system(size: 16, weight: .bold) : .system(size: 16))
                        .onTapGesture {
                            selectedMonth = month
                        }
                }
            }
        }
        .padding(.vertical)
    }

    var months: [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let currentMonth = "This month"
        
        let calendar = Calendar.current
        var months = [currentMonth]
        
        for i in 1..<12 {
            if let date = calendar.date(byAdding: .month, value: -i, to: Date()) {
                let monthName = formatter.string(from: date)
                months.append(monthName)
            }
        }
        
        return months
    }
}

struct JournalEntriesView: View {
    var selectedMonth: String
    
    var body: some View {
        ScrollView {
            if selectedMonth == "This month" {
                VStack(spacing: 16) {
                    JournalEntryView(date: "03", day: "Sun", mood: "Happy", score: "9.2/10", text: "completed a tough assignment, finally got my...")
                    JournalEntryView(date: "02", day: "Sat", mood: "Perplexed", score: "7.4/10", text: "couldn't focus nor solve the problem that was given ...")
                    JournalEntryView(date: "01", day: "Fri", mood: "Calm", score: "8.1/10", text: "today was a normal day, i managed to control my em...")
                    JournalEntryView(date: "29", day: "Thu", mood: "Jealous", score: "2.7/10", text: "i lost it when my friend lied to me and he went on about...")
                }
            } else {
                Text("No entries for this month")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
