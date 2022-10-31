import SwiftUI

struct RegisterStudent: View {
    @State var userImage: Data = Data(count: 0)
    @State var studentFirstName: String = ""
    @State var studentLastName: String = ""
    @State var studentGrade: String = ""
    @State var parentName: String = ""
    @State var parentEmail: String = ""
    @State var parentPhoneNumber: String = ""
    @State var absenses: String = ""   
    @State var depression: String = ""
    @State var happiness: String = ""
    @State var sickDays: String = ""
    @Environment(\.presentationMode) var presentation
    @State var checked: Bool = false
    @Binding var student: Student 
    @Binding var forRegister: Bool 
    var body: some View {
        VStack{
            
            
            HStack (alignment: .center){
                
                Image(uiImage: UIImage(data: self.userImage) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .frame( maxHeight: .infinity)
                    .clipped()
                VStack(alignment: .leading, spacing: 20) {
                        
                    ZStack(alignment: .center) { 
                        TextField("First Name", text: $studentFirstName)
                            .frame(width: 275,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    ZStack(alignment: .center) { 
                        TextField("Last Name", text: $studentLastName)
                            .frame(width: 275,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    ZStack(alignment: .center) { 
                        TextField("Grade", text: $studentGrade)
                            .frame(width: 275,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    if self.forRegister {
                        Toggle(isOn: $checked, label: {
                            Text("Register Student")
                        }).frame(width: 275, height: 40, alignment:.trailing)
                    } 
                    Button { 
                        if self.forRegister{
                            
                        } else {
                            self.presentation.wrappedValue.dismiss()
                        }
                    } label: { 
                        Text(self.forRegister ? "Register Student" : "Done")
                            .padding()
                            .frame(width: 275, height: 40)
                            .background(Color(red: 0, green: 0.21, blue: 0.38))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 2)
                
                
            }
        }
        .onAppear { 
            self.userImage = Data(base64Encoded: "\(self.student.photo)", options: .ignoreUnknownCharacters) ?? Data()
            self.studentFirstName = "\(student.firstName)"
            self.studentLastName = "\(student.lastName)"
            self.studentGrade = "\(student.grade)"
        }
        .navigationTitle(Text(self.forRegister ? "Register Student" : "Student Detail").font(.title3).fontWeight(.bold))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
/*
struct RegisterStudent_Previews: PreviewProvider {
    static var previews: some View {
        RegisterStudent()
    }
}
 */
