import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Email")
                .font(.callout).bold()
            TextField("example@example.com", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Password")
                .font(.callout).bold()
            SecureField("password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {print("Hello Button")}) {
                HStack {
                    Text("Sign In")
                    Spacer()
                }
            }
            .padding()
            .background(Color(UIColor.systemOrange))
            .cornerRadius(10)
            .foregroundColor(Color.white)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20)
    }
}


