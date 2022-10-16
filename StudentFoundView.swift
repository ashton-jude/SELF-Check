import SwiftUI

struct StudentFoundView: View {
    @State var userImage: Image = Image("")
    var body: some View {
        HStack {
            self.userImage
                .resizable()
                .frame(width: 400, height: 600)
            VStack(alignment: .leading, spacing: 10) {
                
                NavigationLink(destination: CheckinView(),label: {
                    Text("Check-in")
                        .bold()
                        .frame(width: 250,height: 40)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    
                })
        }
                
            }
            
            
        
    }
}

struct StudentFoundView_Preview: PreviewProvider {
    static var previews: some View {
        StudentFoundView()
    }
}
