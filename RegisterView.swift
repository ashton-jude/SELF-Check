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
    
    var body: some View {
        VStack{
            
            Text("Register New Student")
                .fontWeight(.bold)
                .font(.system(size: 40))
            
            HStack (alignment: .center, spacing: 30){
                Image(uiImage: UIImage(data: self.userImage) ?? UIImage())
                    .resizable()
                    .frame(width: 250, height: 350)
                VStack {
                    HStack{
                        
                        TextField("First Name", text: $studentFirstName)
                            .buttonStyle(.bordered)
                        TextField("Last Name", text: $studentLastName)
                            .buttonStyle(.bordered)
                            .padding()
                    }
                    HStack{
                        
                        TextField("Grade", text: $studentGrade) 
                            .buttonStyle(.bordered)
                        TextField("Parent Name", text: $parentName)
                            .buttonStyle(.bordered)
                            .padding()
                    }
                    HStack {
                        
                        TextField("Parent Email", text: $parentEmail)
                            .buttonStyle(.bordered)
                        TextField("Parent Phone Number", text: $parentPhoneNumber)
                            .buttonStyle(.bordered)
                            .padding()
                    }
                }
                
                
            }
            .padding(40)
        }
        
    }
}

struct RegisterStudent_Previews: PreviewProvider {
    static var previews: some View {
        RegisterStudent()
    }
}
