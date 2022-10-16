import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var active: Bool = false
    @State var showStudent: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .center) { 
                VStack{
                    Text("Welcome to S.E.L.F Check")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 5 ){ 
                        Text("Email")
                            .font(.callout).bold()
                        TextField("example@example.com", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading, spacing: 5) { 
                        Text("Password")
                            .font(.callout).bold()
                        SecureField("password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .frame(width: 250)
                    Spacer()
                    NavigationLink(  destination: AdiministratorView() , isActive: self.$active) { 
                        Text("Admin Login")
                            .frame(width: 250, height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                            .foregroundColor(Color.black)
                    }
                    NavigationLink(  destination: CheckinView() , isActive: self.$showStudent) { 
                        Button { 
                            self.showStudent.toggle()
                        } label: { 
                            Text("Student Login")
                                .frame(width: 250, height: 40)
                                .background(Color.white)
                                .cornerRadius(8)
                                .foregroundColor(Color.black)
                        }
                        
                    }
            }
                .padding(.vertical)
                
            }
            .background(Image("Orange").ignoresSafeArea())
        }
        .navigationViewStyle(.stack)
    }
}


