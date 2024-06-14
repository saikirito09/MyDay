import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var errorMessage = ""
    @State private var isLoggedIn = false // State variable to control navigation

    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                // Top left circle
                GeometryReader { geometry in
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color.red, Color.clear]), center: .center, startRadius: 0, endRadius: 200))
                        .frame(width: 300, height: 300)
                        .position(x: 150, y: 150)
                        .blur(radius: 30)
                }
                
                // Bottom right circle
                GeometryReader { geometry in
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color.green, Color.clear]), center: .center, startRadius: 0, endRadius: 200))
                        .frame(width: 300, height: 300)
                        .position(x: geometry.size.width - 150, y: geometry.size.height - 150)
                        .blur(radius: 30)
                }

                VStack(spacing: 20) {
                    // Title
                    Text("Welcome Back")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .padding(.top, 100)

                    Spacer()
                    
                    // Username Field
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isUsernameFocused)
                    
                    // Password Field
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isPasswordFocused)
                    
                    // Login Button
                    Button(action: {
                        loginUser()
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .frame(width: 200, height: 50)
                            .background(Color(red: 0.6, green: 0.8, blue: 0.9)) // Light blue color
                            .cornerRadius(15)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                    .padding()

                    // Navigation to RegisterView
                    NavigationLink(destination: RegisterView()) {
                        Text("Don't have an account? Register")
                            .foregroundColor(.blue)
                            .font(.system(size: 16, weight: .medium, design: .default))
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                MainScreen()
            }
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
                        // Store the token or handle the successful login
                        isLoggedIn = true // Navigate to MainView on successful login
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
    }
}
