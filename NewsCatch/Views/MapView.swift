//
//  MapView.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-05.
//

import SwiftUI
import MapKit

struct ArticleLocation: Identifiable{
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    var article: Article
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 57.7087, longitude:11.9751), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    let locations = [
        ArticleLocation(name: "Liseberg", coordinate: CLLocationCoordinate2D(latitude: 57.6968, longitude: 11.99)),
        ArticleLocation(name: "Slotsskogen", coordinate: CLLocationCoordinate2D(latitude: 57.6863684, longitude: 11.942684))
    ]
    
    var body: some View {
        NavigationView{
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate){
                    NavigationLink(destination: ArticleView(article:article)
                    ) {
                        VStack{
                            Circle()
                                .fill(.red)
                                .frame(width: 44,height: 44)
                            Text(location.name)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .navigationTitle("Artiklar via karta")
    }
        
}

