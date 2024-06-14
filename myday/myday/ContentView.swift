import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var animateCircles = false

    var body: some View {
        if navigationModel.isLoggedIn {
            MainScreen()
        } else {
            NavigationStack {
                ZStack {
                    // Background color
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    
                    // Gradient circles with animation and blur
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color.purple, Color.clear]), center: .center, startRadius: 0, endRadius: 200))
                        .frame(width: 300, height: 300)
                        .scaleEffect(animateCircles ? 1.1 : 1.0)
                        .opacity(animateCircles ? 0.7 : 1.0)
                        .position(x: UIScreen.main.bounds.width, y: 0)
                        .blur(radius: 30)
                    
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [Color.blue, Color.clear]), center: .center, startRadius: 0, endRadius: 200))
                        .frame(width: 300, height: 300)
                        .scaleEffect(animateCircles ? 1.1 : 1.0)
                        .opacity(animateCircles ? 0.7 : 1.0)
                        .position(x: 0, y: UIScreen.main.bounds.height)
                        .blur(radius: 30)
                    
                    VStack {
                        // App title with typing animation
                        TypingAnimationModifier(text: "MyDay")
                            .padding(.top, 100)
                        
                        // Subtitle
                        Text("Your personal journaling companion")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.gray)
                            .padding(.bottom, 40)
                        
                        Spacer()
                        
                        // Buttons with dynamic width
                        GeometryReader { geometry in
                            VStack(spacing: 20) {
                                // Login Button
                                NavigationLink(destination: LoginView()) {
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .frame(width: geometry.size.width * 0.9, height: 50)
                                        .background(Color(red: 0.6, green: 0.8, blue: 0.9)) // Light blue color
                                        .cornerRadius(15)
                                }
                                .padding(.bottom, 10)
                                
                                // Register Button
                                NavigationLink(destination: RegisterView()) {
                                    Text("Register")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .frame(width: geometry.size.width * 0.9, height: 50)
                                        .background(Color(red: 0.9, green: 0.7, blue: 0.6)) // Light coral color
                                        .cornerRadius(15)
                                }
                            }
                            .frame(width: geometry.size.width)
                            .position(x: geometry.size.width / 2, y: geometry.size.height - 150)
                        }
                        .frame(height: 200) // Give it a specific height to avoid clipping issues
                    }
                }
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        animateCircles.toggle()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NavigationModel())
    }
}
