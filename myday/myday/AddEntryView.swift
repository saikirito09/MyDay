import SwiftUI

struct AddEntryView: View {
    @Binding var newEntryText: String
    @Binding var newEntryMood: String
    var onAdd: () -> Void

    var body: some View {
        VStack {
            TextField("Entry text", text: $newEntryText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Mood", text: $newEntryMood)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: onAdd) {
                Text("Add Entry")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView(newEntryText: .constant(""), newEntryMood: .constant(""), onAdd: {})
    }
}
