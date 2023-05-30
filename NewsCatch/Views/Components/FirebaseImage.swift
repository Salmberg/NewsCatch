import SwiftUI
import Combine

import FirebaseStorage

final class Loader : ObservableObject {
    let didChange = PassthroughSubject<Data?, Never>()
    var data: Data? = nil {
        didSet { didChange.send(data) }
    }
    
    init(_ id: String){
        let url = id
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }
            
            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}

let placeholder = UIImage(named: "default.png")!

struct FirebaseImage : View {
    
    init(id: String) {
        self.imageLoader = Loader(id)
    }
    
    @ObservedObject private var imageLoader : Loader
    
    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
  
    var body: some View {
        Image(uiImage: image ?? placeholder)
            .resizable()
            .aspectRatio(contentMode: .fill)
        
    }
}

#if DEBUG
struct FirebaseImage_Previews : PreviewProvider {
    static var previews: some View {
        FirebaseImage(id: "random")
    }
}
#endif
