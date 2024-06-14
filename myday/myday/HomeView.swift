import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var selectedMonth: String = "This month"

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView()
            MonthSelectorView(selectedMonth: $selectedMonth)
            JournalEntriesView(selectedMonth: selectedMonth)
            Spacer()
        }
        .padding()
        .onAppear {
            navigationModel.fetchEntries()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(NavigationModel())
    }
}
