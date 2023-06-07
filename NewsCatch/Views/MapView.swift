//
//  MapView.swift
//  NewsCatch
//
//  Created by Linda Bergsängel on 2023-06-05.
//

import SwiftUI
import MapKit

struct MapView: View {
    var articles: [Article]
    @StateObject private var mapAPI = MapAPI()
    @State private var text = ""
    @StateObject var manager = LocationManager()
    
    var body: some View {
        NavigationView{
            Map(coordinateRegion: $manager.region, annotationItems: articles) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)){
                    NavigationLink(destination: ArticleView(article: location.self)) {
                        VStack{
                            Circle()
                                .fill(.red)
                                .frame(width: 44,height: 44)
                            Text(location.location)
                                .foregroundColor(.red)
                        }
                    }
            }

        }
        .navigationTitle("Artiklar via karta")
    }
        
}



