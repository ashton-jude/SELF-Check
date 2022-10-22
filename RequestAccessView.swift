import SwiftUI

struct RequestAccessView: View {
    @State var userImage: Data = Data(count: 0)
    @State var studentFirstName: String = ""
    @State var studentLastName: String = ""
    @State var studentGrade: String = ""
    
    var body: some View {
        VStack {
            
            Text("Request Access from Administrator")
                .fontWeight(.bold)
                .font(.system(size: 40))
            
            HStack (alignment: .center, spacing: 100){
                Image(uiImage: UIImage(data: self.userImage) ?? UIImage())
                    .resizable()
                    .frame(width: 450, height: 400)
                VStack (alignment: .trailing, spacing: 30){
                    
                    TextField("First Name", text: $studentFirstName)
                        .buttonStyle(.bordered)
                        .padding()
                    
                    
                    TextField("Last Name", text: $studentLastName)
                        .buttonStyle(.bordered)
                        .padding()
                    TextField("Grade", text: $studentGrade) 
                        .buttonStyle(.bordered)
                        .padding()
                    
                    Button { 
                        
                    } label: { 
                        Text("Request Access")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                    }
                    
                    
                }
                
            }
        }
        .padding(40)
        
    }
}

struct RequestAccessView_Previews: PreviewProvider {
    static var previews: some View {
        RequestAccessView()
    }
}

