import SwiftUI
import CoreData
import SQLite3

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var showDialog = false
    @State var isStudent = true
    @State private var checked = false
    var body: some View {
        NavigationView{
            ZStack  (alignment: .center){
                HStack(alignment: .center, spacing: 20) { 
                    VStack (alignment: .center, spacing: 30) { 
                        Image("Login_Image")
                            .resizable()
                            .frame(width: 665, height: 930)
                            .cornerRadius(10)
                            .clipped()
                    }.padding()
                    .frame(width: UIScreen.main.bounds.width / 2)
                    Spacer()
                    VStack(alignment: .center, spacing: 20) { 
                        VStack(alignment: .center, spacing: 150){
                        Image("School_Logo")
                            .resizable()
                            .frame(width: 275, height: 275)
                            .cornerRadius(10)
                            .clipped()
                        }
                        TextField("Email Address", text: $email)
                            .frame(width: 250, height: 40)
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(10)
                        SecureField("Password", text: $password)
                            .frame(width: 250, height: 40)
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(10)
                        
                        Toggle(isOn: $checked, label: {
                            Text("Administrator View")
                        }).frame(width: 250, height: 40, alignment:.trailing)
                        
                        Button {
                            if self.checked{
                                
                            }else {
                                
                            }
                        } label: {
                            Text("Login")
                                .padding()
                                .frame(width: 250, height: 40)
                                .background(Color(red: 0, green: 0.21, blue: 0.38))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    
                    .frame(width: UIScreen.main.bounds.width / 2)
                }
            }
            .onAppear(perform: { 
                //SQLManager.shared.createUser(table: User.self)
                //let user = User(id: 1, email: "ashton.reddy@outlook.com", password: "123123")
                //SQLManager.shared.insertData(user: user)
                SQLManager.shared.getUserData(id: 1)
                
            })
            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
            .actionSheet(isPresented: $showDialog){
                ActionSheet(title: Text("Select Type"), buttons: [
                    .default(Text("Student"), action: { 
                        self.isStudent = true
                    }),
                    .default(Text("Admin"), action: { 
                        self.isStudent = false
                    })
                ])
            }
        }.navigationViewStyle(.stack)
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

 
