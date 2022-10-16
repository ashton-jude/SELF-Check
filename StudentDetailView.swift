/*
import SwiftUI
import RegisterStudent

struct StudentDetailView: View {
    var body: some View {
    
        VStack{
            
            Text("Register New Student")
                .fontWeight(.bold)
                .font(.system(size: 40))
            
            HStack (alignment: .center, spacing: 30){
                Button {
                    print("add photo button was tapped")
                } label: {
                    Image(systemName:"photo.fill.on.rectangle.fill")
                        .font(.system(size: 350))
                }
                VStack {
                    HStack{
                        
                        Text( text: $studentFirstName)
                            .buttonStyle(.bordered)
                        Text( text: $studentLastName)
                            .buttonStyle(.bordered)
                            .padding()
                    }
                    HStack{
                        
                        Text( text: $studentGrade) 
                            .buttonStyle(.bordered)
                        Text( text: $parentName)
                            .buttonStyle(.bordered)
                            .padding()
                    }
                    HStack {
                        
                        Text( text: $parentEmail)
                            .buttonStyle(.bordered)
                        Text( text: $parentPhoneNumber)
                            .buttonStyle(.bordered)
                            .padding()
                    }
                }
                
                
            }
            .padding(40)
        }
        
    }
}

struct StudentDetail_Preview: PreviewProvider {
    static var previews: some View {
        RegisterStudent()
    }
}
 */
