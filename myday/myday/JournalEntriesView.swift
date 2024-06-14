import SwiftUI

struct JournalEntriesView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var selectedMonth: String

    var body: some View {
        ScrollView {
            if selectedMonth == "This month" {
                VStack(spacing: 16) {
                    ForEach(navigationModel.entries) { entry in
                        JournalEntryView(date: entry.dateString, day: entry.dayString, mood: entry.mood, score: "N/A", text: entry.text)
                    }
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
