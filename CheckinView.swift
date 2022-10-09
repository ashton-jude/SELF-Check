
import SwiftUI

struct CheckinView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "arrowshape.turn.up.backward")
                    .imageScale(.large)
                    .foregroundColor(.white)
                Text("Go back or turn on sleep mode?")
                NavigationLink(destination: SleepView(),label: {
                    Text("Back?")
                        .bold()
                        .frame(width: 120,height: 25)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    
                })
                Form {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
                    Text("No Activity")
                }
            }
            Button(action: 
                    {print("Button action")
            }) {
                HStack {
                    Image(systemName: "moon.fill")
                    Text("Sleep Mode")
                    }
            }
        }
    }
}
struct CheckinView_Preview: PreviewProvider {
    static var previews: some View {
        CheckinView()
    }
}
