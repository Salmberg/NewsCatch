//
//  Map.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-05.
//

import Foundation
import MapKit

struct Adress: Codable{
    let data: [Datum]
}

struct Datum: Codable{
    let latitude, longitude: Double
    let name: String?
}

struct ArticleLocation: Identifiable{
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class MapAPI: ObservableObject{
    private let BASE_URL = "http://api.positionstack.com/v1/forward"
    private let API_KEY = "97b7dd276173c0860d9087a83961ea95"
    
    @Published var region: MKCoordinateRegion
    @Published var coordinates = []
    @Published var locations: [ArticleLocation] = []
    
    init(){
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 57.7087, longitude:11.9751), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        //self.locations.insert(ArticleLocation(name: "Liseberg", coordinate: CLLocationCoordinate2D(latitude: 57.6968, longitude: 11.99)), at: 0)
    }
    
    func getLocation(adress: String, delta: Double){
        let pAdress = adress.replacingOccurrences(of: " ", with: "%20")
        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAdress)"
        print(url_string)
        guard let url = URL(string: url_string) else {
            print("invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                print(error!.localizedDescription)
                return
            }
            guard let newCoordinates = try? JSONDecoder().decode(Adress.self, from: data) else {return}
            
            if newCoordinates.data.isEmpty{
                print("Could not find the adress")
                return
            }
            
            DispatchQueue.main.async{
                let details = newCoordinates.data[0]
                let lat = details.latitude
                let lon = details.longitude
                let name = details.name
                
                self.coordinates = [lat, lon]
                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude:lon), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
                
                let new_location = ArticleLocation(name: name ?? "Marker", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
                self.locations.removeAll()
                
                print("Succesfully loaded the location!")
            }
        }
        .resume()
    }
}
