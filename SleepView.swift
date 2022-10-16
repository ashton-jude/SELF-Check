import SwiftUI

struct SleepView: View {
    @State var userImage: Image = Image("")
    var body: some View {
        
            VStack {
                Image(systemName: "arrowshape.turn.up.backward")
                    .imageScale(.large)
                    .foregroundColor(.white)
                Text("School Logo")
                self.userImage
                    .resizable()
                    .frame(width: 200, height: 200)
                    
                    
                NavigationLink(destination: SleepView(),label: {
                    Text("Back?")
                        .bold()
                        .frame(width: 120,height: 25)
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
