import SwiftUI

struct SleepView: View {
    var body: some View {
        VStack{
            navigationTitle("SecondView")
            offset()
            }
    }
}
struct SleepView_Preview: PreviewProvider {
    static var previews: some View {
        SleepView()
    }
}
