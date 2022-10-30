import SwiftUI
import UIKit


struct CustomCameraView: UIViewControllerRepresentable {
    @Binding var image: Data
    @Binding var showCameraView: Bool
    var backAction: () -> Void 
    var doneAction: () -> Void
    func makeCoordinator() -> CustomCameraView.Coordinator {
        Coordinator(cameraView: self)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomCameraView>) -> some UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.sourceType = .camera
        return controller
        
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<CustomCameraView>) {
        
    }
    
    class Coordinator: 
        NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        var parent: CustomCameraView
        init(cameraView: CustomCameraView) {
            self.parent = cameraView
            
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let orientationImage = image.fixOrientation() ?? UIImage()
            self.parent.image = orientationImage.pngData() ?? Data(count: 0)
            self.parent.showCameraView = false
            self.parent.doneAction()
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.showCameraView = false
            self.parent.backAction()
            
        }
    }
}

extension UIImage {
    func fixOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
