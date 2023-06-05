//
//  MapView.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-05.
//

import SwiftUI
import MapKit

struct MapView: View {
    var article: Article
    @StateObject private var mapAPI = MapAPI()
    @State private var text = ""
    //@State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 57.7087, longitude:11.9751), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    /*
    let locations = [
        ArticleLocation(name: "Liseberg", coordinate: CLLocationCoordinate2D(latitude: 57.6968, longitude: 11.99)),
        ArticleLocation(name: "Slotsskogen", coordinate: CLLocationCoordinate2D(latitude: 57.6863684, longitude: 11.942684))
    ]
     */
    
    var body: some View {
        NavigationView{
            Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations) { tja in
                MapAnnotation(coordinate: tja.coordinate){
                    NavigationLink(destination: ArticleView(article:article)
                    ) {
                        VStack{
                            Circle()
                                .fill(.red)
                                .frame(width: 44,height: 44)
                            Text(tja.name)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .onAppear{
                mapAPI.getLocation(adress: article.location, delta: 0.1)
            }
        }
        .navigationTitle("Artiklar via karta")
    }
        
}

