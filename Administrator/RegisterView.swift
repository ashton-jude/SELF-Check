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
    @Binding var student: Student 
    
    var body: some View {
        VStack{
            
            Text("Register New Student")
                .fontWeight(.bold)
                .font(.system(size: 40))
            
            HStack (alignment: .center, spacing: 30){
                Spacer()
                Image(uiImage: UIImage(data: self.userImage) ?? UIImage())
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 1.75)
                VStack(alignment: .leading, spacing: 20) {
                        
                    ZStack(alignment: .center) { 
                        TextField("First Name", text: $studentFirstName)
                            .frame(width: 250,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    ZStack(alignment: .center) { 
                        TextField("Grade", text: $studentGrade)
                            .frame(width: 250,height: 40)
                            .padding(.leading, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.1)))
                    
                    Button { 
                        
                    } label: { 
                        Text("Register Student")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                    }
                }
                Spacer()
                
                
            }
            .padding(40)
        }
        .onAppear { 
            self.userImage = Data(base64Encoded: "\(self.student.photo)", options: .ignoreUnknownCharacters) ?? Data()
            self.studentFirstName = "\(student.firstName)"
            self.studentLastName = "\(student.lastName)"
            self.studentGrade = "\(student.grade)"
        }
        .navigationTitle(Text("Register Student").font(.title3).fontWeight(.bold))
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
