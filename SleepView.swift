import SwiftUI

struct SleepView: View {
    @State var userImage: Image = Image("")
    var body: some View {
        
            VStack {
                
                self.userImage
                    .resizable()
                    .frame(width: 200, height: 200)
                    
                    
                NavigationLink(destination: SleepView(),label: {
                    Text("Check-in")
                        .bold()
                        .frame(width: 400,height: 40)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    
                })
                
            }
            
            
        
    }
}

struct SleepView_Preview: PreviewProvider {
    static var previews: some View {
        SleepView()
    }
}
