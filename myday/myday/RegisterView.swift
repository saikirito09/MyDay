import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var errorMessage = ""

    var body: some View {
        ZStack {
            // Background color
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(RadialGradient(gradient: Gradient(colors: [Color.orange, Color.clear]), center: .center, startRadius: 0, endRadius: 200))
                .frame(width: 300, height: 300)
                .position(x: 0, y: 0)
                .blur(radius: 30)
            
            Circle()
                .fill(RadialGradient(gradient: Gradient(colors: [Color.pink, Color.clear]), center: .center, startRadius: 0, endRadius: 200))
                .frame(width: 300, height: 300)
                .position(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height)
                .blur(radius: 30)

            VStack(spacing: 20) {
                // Title
                Text("Create An Account")
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

                // Email Field
                TextField("Email", text: $email)
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
                    // Handle registration
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
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
