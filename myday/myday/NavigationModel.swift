import SwiftUI
import Combine

class NavigationModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var username: String = ""
    @Published var entries: [JournalEntry] = []
    private var token: String?

    private var cancellables = Set<AnyCancellable>()

    func login(username: String, token: String) {
        self.username = username
        self.token = token
        self.isLoggedIn = true
        fetchEntries()
    }
    
    func logout() {
        self.username = ""
        self.token = nil
        self.isLoggedIn = false
        self.entries = []
    }

    func fetchEntries() {
        guard let url = URL(string: "http://localhost:5002/api/entries/\(username)") else { return }
        guard let token = token else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    let responseBody = String(data: output.data, encoding: .utf8) ?? "No response body"
                    print("Error response: \(responseBody)")
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [JournalEntry].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching entries: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] entries in
                self?.entries = entries
            })
            .store(in: &cancellables)
    }

    func addEntry(entry: JournalEntry) {
        guard let url = URL(string: "http://localhost:5002/api/entries") else { return }
        guard let token = token else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        guard let httpBody = try? JSONEncoder().encode(entry) else {
            print("Error encoding entry")
            return
        }
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error adding entry: \(error)")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("No data or no response")
                return
            }

            if response.statusCode != 201 {
                let responseBody = String(data: data, encoding: .utf8) ?? "No response body"
                print("Error response: \(response.statusCode), body: \(responseBody)")
                return
            }

            self.fetchEntries()
        }.resume()
    }
}
