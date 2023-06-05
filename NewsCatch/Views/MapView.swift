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

