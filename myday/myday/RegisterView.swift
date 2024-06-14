import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var errorMessage = ""
    @EnvironmentObject var navigationModel: NavigationModel

    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(RadialGradient(gradient: Gradient(colors: [Color.orange, Color.clear]), center: .center, startRadius: 0, endRadius: 200))
                    .frame(width: 300, height: 300)
                    .position(x: 150, y: 150)
                    .blur(radius: 30)
                
                Circle()
                    .fill(RadialGradient(gradient: Gradient(colors: [Color.pink, Color.clear]), center: .center, startRadius: 0, endRadius: 200))
                    .frame(width: 300, height: 300)
                    .position(x: UIScreen.main.bounds.width - 150, y: UIScreen.main.bounds.height - 150)
                    .blur(radius: 30)

                VStack(spacing: 20) {
                    // Title
                    Text("Create Your Account")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .padding(.top, 100)

                    Spacer()
                    
                    // Username Field
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)

                    // Password Field
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)

                    // Confirm Password Field
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)

                    // Register Button
                    Button(action: {
                        registerUser()
                    }) {
                        Text("Register")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                    .padding()

                    // Navigation to LoginView
                    NavigationLink(destination: LoginView()) {
                        Text("Already have an account? Login")
                            .foregroundColor(.blue)
                            .font(.system(size: 16, weight: .medium, design: .default))
                    }
                    .padding(.top, 10)

                    Spacer()
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
    }
    
    func registerUser() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            showAlert = true
            return
        }
        
        guard let url = URL(string: "http://localhost:5002/api/users/register") else {
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
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
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
                        // Store the token or handle the successful registration
                        navigationModel.login(username: username, token: token) // Pass the token to login method
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(NavigationModel())
    }
}
