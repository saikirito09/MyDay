import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var isEditing = false
    @State private var newUsername = ""

    var body: some View {
        NavigationStack {
            VStack {
                // Profile Picture
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .padding(.top, 50)
                
                // Profile Information
                VStack(spacing: 20) {
                    if isEditing {
                        TextField("Username", text: $newUsername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        HStack {
                            Button(action: {
                                // Save the changes
                                navigationModel.username = newUsername
                                isEditing = false
                            }) {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            Button(action: {
                                // Cancel the changes
                                isEditing = false
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                    } else {
                        Text(navigationModel.username)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                .padding()
                
                Spacer()
                
                // Edit Profile Button
                Button(action: {
                    isEditing = true
                    newUsername = navigationModel.username
                }) {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(NavigationModel())
    }
}
