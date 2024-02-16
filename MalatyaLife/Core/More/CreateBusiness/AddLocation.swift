import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct AddLocation: View {
    @StateObject var locationManager = LocationManager()
    @State var camera: MapCameraPosition
    @State var address: String = ""
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    var bounds: MapCameraBounds {
        let region = MKCoordinateRegion(center:locationManager.lastLocation?.coordinate ?? CLLocationCoordinate2D(), span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03))
        return MapCameraBounds(centerCoordinateBounds: region, minimumDistance: 2000, maximumDistance: 5000)
    }
    
    var body: some View {
        Map(coordinateRegion: $region)
            .overlay {
                Image(systemName: "pin.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.orange.gradient)
            }
            .mapStyle(.standard(pointsOfInterest: .including([MKPointOfInterestCategory.parking, .atm, .bank, .bakery])))
            .onMapCameraChange { context in
                camera = MapCameraPosition.region(context.region)
            }
        
            .onReceive(locationManager.$lastLocation) { location in
                if let location = location {
                    region = MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                    )
                    Task {
                        _ = await lookupCurrentLocation()
                    }
                }
            }

            .safeAreaInset(edge: .bottom) {
                VStack(spacing:10) {
                    Text(address)
                        .font(.subheadline).bold()
                    HStack {
                        Text("Latitude: \(region.center.latitude)")
                        Text("Longitude: \(region.center.longitude)")
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.thinMaterial)
            }
            .onChange(of: camera) { oldValue, newValue in
                Task {
                    if let location = await lookupCurrentLocation() {
                        address = ""
                        address += location.name ?? ""
                        address += location.locality ?? ""
                    }
                }
            }
    }
    func lookupCurrentLocation() async -> CLPlacemark? {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            return placemarks.first
        } catch {
            print("Failed to find location: \(error)")
            return nil
        }
    }

}

class LocationManager: NSObject, ObservableObject {
    let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.first
    }
}
