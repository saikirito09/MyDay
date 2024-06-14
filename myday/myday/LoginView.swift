import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var showAlert = false
    @State private var errorMessage = ""
    @EnvironmentObject var navigationModel: NavigationModel

    var body: some View {
        NavigationStack {
            ZStack {
                // More colorful background
                LinearGradient(gradient: Gradient(colors: [.blue, .purple, .pink, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)

                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red, width: CGFloat(max(0, wrongUsername)))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(Color.red, width: CGFloat(max(0, wrongPassword)))
                    
                    Button("Login") {
                        loginUser()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func loginUser() {
        guard let url = URL(string: "http://localhost:5002/api/users/login") else {
            errorMessage = "Invalid URL"
            showAlert = true
            return
        }

        let body: [String: String] = ["username": username, "password": password]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            errorMessage = "Error creating JSON body"
            showAlert = true
            return
        }

        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error: \(error.localizedDescription)"
                    showAlert = true
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received"
                    showAlert = true
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    errorMessage = "Error: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))"
                    showAlert = true
                }
                return
            }

            do {
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: [])
                if let responseDict = responseJSON as? [String: Any], let token = responseDict["token"] as? String {
                    DispatchQueue.main.async {
                        // Store the token and handle the successful login
                        navigationModel.login(username: username, token: token) // Pass token to login method
                    }
                } else {
                    DispatchQueue.main.async {
                        errorMessage = "Unexpected response format"
                        showAlert = true
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Error parsing response"
                    showAlert = true
                }
            }
        }.resume()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(NavigationModel())
    }
}
