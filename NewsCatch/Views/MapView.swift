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
           //ForEach(articles) { article in
                Map(coordinateRegion: $manager.region, annotationItems: articles) { location in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                        /*
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
                         */
                         
                    }
               // }
               //.onAppear{
                //    mapAPI.getLocation(adress: article.location, delta: 0.1)
               // }
            
           
        }
        .navigationTitle("Artiklar via karta")
    }
        
}



