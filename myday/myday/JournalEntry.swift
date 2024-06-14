import Foundation

struct JournalEntry: Identifiable, Codable {
    var id: String? // MongoDB ObjectId
    var user: String
    var text: String
    var mood: String
    var tags: [String]
    var createdAt: Date = Date() // Default value for createdAt

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: createdAt)
    }

    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: createdAt)
    }
}
