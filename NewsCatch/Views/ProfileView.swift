//
//  ProfileView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import FirebaseAuth
import Firebase
import Kingfisher
import FirebaseStorage
import Combine

struct ProfileView: View {
    let db = Firestore.firestore()
    @State var isAddArticle = false
    var user = Auth.auth().currentUser
    @State var username = "unknown"
    @State var selectedImage: UIImage? = nil
    @State var imageURL: URL? = nil
    @State private var userModel = User(id: "", name: "", username: "", email: "", joined: 0, imageURL: nil)

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                        }
                        .background(Color.gray)
                        .ignoresSafeArea()

                        
                          
                        

                        VStack(spacing: 10) {
                            Button(action: {
                                       isAddArticle = true
                                   }) {
                                       KFImage(imageURL)
                                           .resizable()
                                           .placeholder {
                                               Image(systemName: "photo")
                                                   .resizable()
                                                   .aspectRatio(contentMode: .fit)
                                                   .frame(height: 120)
                                           }
                                           .aspectRatio(contentMode: .fit)
                                           .frame(height: 120)
                                           .cornerRadius(90)
                                           .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                                           .padding(20)
                                   }
                                   .onTapGesture {
                                       isAddArticle = true
                                   }
                                   .sheet(isPresented: $isAddArticle) {
                                       ImagePickerView2(selectedImage: $selectedImage, imageURL: $imageURL)
                                           .onDisappear {
                                               uploadImage()
                                           }
                                   }
                               
                                

                            if let user = Auth.auth().currentUser {
                                let email = user.email ?? ""
                                let displayName = user.displayName ?? ""
                                let profilePictureURL = user.photoURL?.absoluteString ?? ""
                                
                                

                                HStack {
                                    Image(systemName: "at")
                                        .resizable()
                                        .frame(width: 20, height: 20)

                                    Text(email)
                                        .font(.system(size: 20))
                                }
                                HStack {
                                    Image(systemName: "person")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text(username)
                                }

                                Text(profilePictureURL)
                            }

                            VStack(spacing: 10) {

                               
                                
                                
                            }
                            .onAppear {
                                updateUsername()
                            }
                        }
                        .background(Color.gray)

                        Button(action: {
                            // Action to perform when the ZStack is clicked
                        }) {
                            NavigationLink(destination: MyArticlesView()) {
                                ZStack {
                                    VStack {
                                        Text("MINA ARTIKLAR")
                                            .font(.system(size: 25))
                                            .foregroundColor(.white)
                                            .padding(.top, 5)
                                            .bold()
                                        VStack {
                                            HStack {
                                                //Remove these dummy images when real data is used
                                                Image("ocean")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                                Image("viking")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                            }
                                            Button(action: {
                                                
                                            }) {
                                                NavigationLink(destination: MyArticlesView()) {
                                                    Text("Se alla")
                                                        .font(.title2)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                        .padding()
                                                        .background(Color.blue)
                                                        .cornerRadius(10)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                            }


                                        }
                                        Spacer()
                                    }
                                    .background(Color(red: 31/255, green: 59/255, blue: 77/255))
                                    .cornerRadius(15)
                                    .frame(width: UIScreen.main.bounds.width * 0.98)
                                }
                            }
                        }
                        .padding(20)
                        .background(Color.gray)

                        Button(action: {
                            
                        }) {
                            NavigationLink(destination: MyFavouriteArticlesView()) {
                                ZStack {
                                    VStack {
                                        Text("SPARADE ARTIKLAR")
                                            .font(.system(size: 25))
                                            .foregroundColor(.white)
                                            .padding(.top, 5)
                                            .bold()
                                        VStack {
                                            HStack {
                                                //Remove these dummy images when real data is used
                                                Image("ocean")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                                Image("viking")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                                    .padding()
                                            }
                                            Button(action: {
                                                
                                            }) {
                                                NavigationLink(destination:MyFavouriteArticlesView()) {
                                                    Text("Se alla")
                                                        .font(.title2)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                        .padding()
                                                        .background(Color.blue)
                                                        .cornerRadius(10)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                            }

                                        }
                                        Spacer()
                                    }
                                    .background(Color(red: 31/255, green: 59/255, blue: 77/255))
                                    .cornerRadius(15)
                                    .frame(width: UIScreen.main.bounds.width * 0.98)
                                }
                            }
                        }

                        Button(action: {
                            // Action to perform when the ZStack is clicked
                        }) {
                            NavigationLink(destination: MyFavouriteAuthorsView()) {
                                ZStack {
                                    VStack {
                                        Text("FAVORITSKRIBENTER")
                                            .font(.system(size: 25))
                                            .foregroundColor(.white)
                                            .padding(.top, 10)
                                            .bold()
                                        VStack {
                                            HStack {
                                                VStack {
                                                    Image(systemName: "person.crop.circle.fill")
                                                        .font(.system(size: 80))
                                                        .padding(20)
                                                    Text("Skribent 1")
                                                        .font(.system(size: 15))
                                                }
                                                VStack {
                                                    Image(systemName: "person.crop.circle.fill")
                                                        .font(.system(size: 80))
                                                        .padding(20)
                                                    Text("Skribent 2")
                                                        .font(.system(size: 15))
                                                }
                                            }
                                            Button(action: {
                                                
                                            }) {
                                                NavigationLink(destination: MyFavouriteAuthorsView()) {
                                                    Text("Se alla")
                                                        .font(.title2)
                                                        .bold()
                                                        .foregroundColor(.white)
                                                        .padding()
                                                        .background(Color.blue)
                                                        .cornerRadius(10)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                            }
                                            

                                        }
                                        Spacer()
                                    }
                                    .background(Color(red: 31/255, green: 59/255, blue: 77/255))
                                    .cornerRadius(15)
                                    .frame(width: UIScreen.main.bounds.width * 0.98)
                                }
                            }
                        }
                        .padding(20)
                        .background(Color.gray)

                    }
                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                        } catch {
                            print("Failed to sign out: \(error.localizedDescription)")
                            print("clicked")
                        }
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    
                    .padding(.bottom, 100)
                }
                .background(Color.gray)
                .ignoresSafeArea(.all)
                .padding(.bottom, 20)

                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        HStack {
                            Button(action: {
                                isAddArticle = true
                            }, label: {
                                Image(systemName: "note.text.badge.plus")
                                    .font(.system(size: 35))
                                    .padding(20)
                                    .foregroundColor(Color.white)
                            })
                            .sheet(isPresented: $isAddArticle) {
                                AddArticleView()
                            }

                            NavigationLink(destination: MyFavouriteArticlesView()) {
                                Image(systemName: "heart.text.square.fill")
                                    .font(.system(size: 35))
                                    .padding(20)
                                    .foregroundColor(Color.white)
                            }

                            NavigationLink(destination: MyFavouriteAuthorsView()) {
                                Image(systemName: "person.text.rectangle.fill")
                                    .font(.system(size: 35))
                                    .padding(20)
                                    .foregroundColor(Color.white)
                            }

                            NavigationLink(destination: ReminderView()) {
                                Image(systemName: "calendar.badge.clock")
                                    .font(.system(size: 35))
                                    .padding(20)
                                    .foregroundColor(Color.white)
                            }
                        }
                        .padding(.bottom, 70)
                        .padding(.leading, 30)
                        .padding(.trailing, 20)
                        .background(Color(red: 31/255, green: 59/255, blue: 77/255))
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100)
                    }
                }
            }
            
        }
        .onAppear {
            updateUserImageURL()
        }

        
        .onAppear {
            // Retrieve the profile picture URL from UserDefaults
            if let currentUser = Auth.auth().currentUser {
                if let profilePictureURL = UserDefaults.standard.string(forKey: "ProfilePictureURL_\(currentUser.uid)") {
                    imageURL = URL(string: profilePictureURL)
                }
            }
        }
            
            
        
    }
        
        
    

    func updateUsername() {
        if let user = Auth.auth().currentUser {
            db.collection("users").document(user.uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let username = data?["username"] as? String ?? "unknown"
                    DispatchQueue.main.async {
                        self.username = username
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    
    
    //     ±±±± Phil's "did not manage to move the code to ProfileImageViewModel and have it working funcs" corner.±±±±
       
                
        func uploadImage() {
            guard let selectedImage = selectedImage else { return }
            
            // Convert the selected image to Data
            guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else { return }
            
            // Generate a unique filename for the uploaded image
            let filename = UUID().uuidString + ".jpg"
            
            // Reference to the Firebase Storage for the user's image data
            guard let currentUser = Auth.auth().currentUser else { return }
            let storageRef = Storage.storage().reference().child("Profile-Image/\(currentUser.uid)/\(filename)")
            
            // Upload the image data to Firebase Storage
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }
                
                // Get the download URL of the uploaded image
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error retrieving download URL: \(error)")
                        return
                    }
                    
                    if let downloadURL = url?.absoluteString {
                        // Update the profile picture URL in the user's data
                        guard let currentUser = Auth.auth().currentUser else { return }
                        let changeRequest = currentUser.createProfileChangeRequest()
                        changeRequest.photoURL = URL(string: downloadURL)
                        changeRequest.commitChanges { error in
                            if let error = error {
                                print("Error updating profile picture URL: \(error)")
                                return
                            }
                            imageURL = URL(string: downloadURL)
                            print("Profile picture URL updated successfully")
                            
                            // Save the profile picture URL to UserDefaults
                            UserDefaults.standard.set(downloadURL, forKey: "ProfilePictureURL_\(currentUser.uid)")
                            print("Profile picture URL updated and saved successfully")
                            
                            // Update the profile picture URL in Firestore
                            let db = Firestore.firestore()
                            let userUID = currentUser.uid
                            let profileData = ["imageURL": downloadURL]
                            db.collection("users").document(userUID).updateData(profileData) { error in
                                if let error = error {
                                    print("Error updating profile picture URL in Firestore: \(error)")
                                    return
                                }
                                print("Profile picture URL updated in Firestore successfully")
                            }
                        }
                    }
                }
            }
        }

            
        
        // Function to update the imageURL property in the User model
            func updateUserImageURL() {
                guard let currentUser = Auth.auth().currentUser else {
                    return
                }

                let db = Firestore.firestore()
                let userUID = currentUser.uid

                // Retrieve the user document from Firestore
                db.collection("users").document(userUID).getDocument { document, error in
                    if let error = error {
                        print("Error retrieving user document: \(error)")
                        return
                    }

                    guard let document = document else {
                        print("User document does not exist")
                        return
                    }

                    if let imageURL = document["imageURL"] as? String {
                        // Update the imageURL property in the User model
                        userModel.imageURL = imageURL
                    }
                }
            }
        
        

        
        
        
                func updateProfilePictureURL(_ imageURL: URL) {
                        guard let currentUser = Auth.auth().currentUser else {
                            return
                        }
        
                        let changeRequest = currentUser.createProfileChangeRequest()
                        changeRequest.photoURL = imageURL
        
                        changeRequest.commitChanges { error in
                            if let error = error {
                                print("Error updating profile picture URL: \(error)")
                                return
                            }
        
                            print("Profile picture URL updated successfully")
                        }
                    }
    
    
}

struct ImagePickerView2: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    @Binding var imageURL: URL?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView2>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView2>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView2
        
        init(_ parent: ImagePickerView2) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                parent.imageURL = nil
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}





struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
