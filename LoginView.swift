import SwiftUI
import CoreData

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var showDialog = false
    @State var isStudent = true
    @FetchRequest(sortDescriptors:[NSSortDescriptor(keyPath: \Users.id,ascending:true)], animation: .default)
    private var users: FetchedResults<Users>
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        NavigationView{
            ZStack  (alignment: .center){
                HStack(alignment: .center, spacing: 20) { 
                    VStack (alignment: .center, spacing: 10) { 
                        Image("Logo")
                            .resizable()
                            .frame(width: 180, height: 180)
                            .cornerRadius(10)
                            .clipped()
                    }
                    .frame(width: UIScreen.main.bounds.width / 2)
                    Spacer()
                    VStack(alignment: .center, spacing: 20) { 
                        TextField("Email Address", text: $email)
                            .frame(width: 250, height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                        SecureField("Password", text: $password)
                            .frame(width: 250, height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                        Button { 
                            self.showDialog.toggle()
                        } label: { 
                            ZStack(alignment: .center) { 
                                HStack(alignment: .center) { 
                                    Text(self.isStudent ? "Student" : "Admin")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                .padding(.horizontal)
                                .padding(.vertical,8)
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .frame(width: 250)
                        }
                        Button { 
                            let user = users.filter({$0.email ?? "" == self.email })
                            if user.count > 0{
                                print("user is regitered")
                            } else{
                                let user = Users(context: self.viewContext)
                                user.id = UUID().uuidString
                                user.email = self.email
                                user.password = self.password
                                self.viewContext.perform {
                                    try? self.viewContext.save()
                                    
                                }
                            }
                            print(users.count)
                        } label: { 
                            Text("Login")
                                .padding()
                                .frame(width: 250, height: 40)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width / 2)
                }
            }
            .background(Image("Orange").ignoresSafeArea())
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
/*
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
 */
