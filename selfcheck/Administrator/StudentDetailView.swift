
import SwiftUI

struct StudentDetailView: View {
    @Binding var student: Student
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
                        
                        Text("random")
                            .buttonStyle(.bordered)
                        Text( "random")
                            .buttonStyle(.bordered)
                            .padding()
                    }
                    HStack{
                        
                        Text( "random") 
                            .buttonStyle(.bordered)
                        
                    }
                }
                
                
            }
            .padding(40)
        }
        
    }
}
/*
struct StudentDetail_Preview: PreviewProvider {
    static var previews: some View {
        RegisterStudent()
    }
}
 
 */
