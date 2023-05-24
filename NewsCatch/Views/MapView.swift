//
//  MapView.swift
//  NewsCatch
//
//  Created by David Salmberg on 2023-05-22.
//

import SwiftUI
import MapKit

struct MapView: View {
    var mapViewModel = MapViewModel()
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3323341, longitude: -122.0312186), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    
    @State var places = [
        Location(newsName: "School News-site", latitude: 37.329, longitude: -122.032),
        Location(newsName: "Traffic News-site", latitude: 37.332, longitude: -122.03),
        Location(newsName: "Robbery News-site", latitude: 37.335, longitude: -122.029)
    ]
    
    let buttonColor = Color.gray // Set the button color to gray
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                interactionModes: [.all],
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: places) { place in
                    MapAnnotation(coordinate: place.coordinate, anchorPoint:
                                    CGPoint(x: 0.5, y: 0.5)) {
                        MapPinView(location: place)
                        
                    }
            }
            Button(action: {
                addPin()
            }) {
                Text("Add Your Current News Location")
                    .foregroundColor(.white)
                    .padding()
                    .background(buttonColor)
                    .cornerRadius(8)
            }
            Button(action: {
                mapViewModel.startLocationUpdates()
            }) {
                Text("Start GPS Updates")
                    .foregroundColor(.white)
                    .padding()
                    .background(buttonColor)
                    .cornerRadius(8)
            }
        }
    }
    
    func addPin() {
        if let location = mapViewModel.location {
            let newPlace = Location(newsName: "here", latitude: location.latitude, longitude: location.longitude)
            places.append(newPlace)
        }
    }
}

struct MapPinView: View {
    var location: Location
    
    var body: some View {
        VStack {
            Image(systemName: "newspaper")
                .resizable()
                .frame(width: 40, height: 40)
            Text(location.newsName)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
