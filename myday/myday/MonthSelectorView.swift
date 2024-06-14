import SwiftUI

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
