import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct AddLocation: View {
    @ObservedObject var viewModel = BusinessViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var camera: MapCameraPosition = .region(.init(center: .merkez, span: .initialSpan))
    @State private var coordinate: CLLocationCoordinate2D = .merkez
    @State private var mapSpan: MKCoordinateSpan = .initialSpan
    @State private var annotationTitle: String = ""
    @State private var updatesCamera: Bool = true
    @State private var displaysTitle: Bool = true
    
    var body: some View {
        MapReader { proxy in
            Map(position: $camera) {
                Annotation(displaysTitle ? annotationTitle : "", coordinate: coordinate) {
                    DraggablePin(proxy: proxy ,coordinate: $coordinate) { coordinate in
                        findCoordinateName()
                        guard updatesCamera else { return }
                        let newRegion = MKCoordinateRegion(
                            center: coordinate,
                            span: mapSpan
                        )
                        withAnimation {
                            camera = .region(newRegion)
                        }
                        
                        viewModel.businesslatitude = coordinate.latitude
                        viewModel.businesslongitude = coordinate.longitude
                    }
                }
            }
            .onMapCameraChange(frequency: .continuous) { ctx in
                mapSpan = ctx.region.span
            }
            .safeAreaInset(edge: .bottom, content: {
                HStack {
                    annotationTitle.isEmpty ? nil : VStack {
                        Text(annotationTitle)
                    }
                    .frame(maxWidth: .infinity)
                }
                .textScale(.secondary)
                .padding(15)
                .background(.ultraThinMaterial)
            })
            .onAppear(perform: findCoordinateName)
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Vazgeç") {
                    coordinate = .merkez
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Kaydet") {
                    viewModel.businesslatitude = coordinate.latitude
                    viewModel.businesslongitude = coordinate.longitude
                    
                    dismiss()
                }
            }
        }
        .onAppear {
            // Eğer viewModel'deki koordinatlar default değerlerden farklıysa, bu koordinatları kullanın.
            if viewModel.businesslatitude != 0 && viewModel.businesslongitude != 0 {
                coordinate = CLLocationCoordinate2D(latitude: viewModel.businesslatitude, longitude: viewModel.businesslongitude)
            }
        }
    }
    
    func findCoordinateName() {
        annotationTitle = ""
        Task {
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let geoDecoder = CLGeocoder()
            if let name = try? await geoDecoder.reverseGeocodeLocation(location).first?.name {
                annotationTitle = name
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    NavigationStack {
        AddLocation()
    }
}

/// Custom Draggable Pin Annotation
@available(iOS 17.0, *)
struct DraggablePin: View {
    var tint: Color = .red
    var proxy: MapProxy
    @Binding var coordinate: CLLocationCoordinate2D
    var onCoordinateChange: (CLLocationCoordinate2D) -> ()
    @State private var isActive: Bool = false
    @State private var translation: CGSize = .zero
    
    
    var body: some View {
        GeometryReader {
            let frame = $0.frame(in: .global)
            
            Image(systemName: "mappin")
                .font(.title)
                .foregroundStyle(tint.gradient)
                .animation(.snappy, body: { content in
                    content
                        .scaleEffect(isActive ? 1.3 : 1, anchor: .bottom)
                })
                .frame(width: frame.width, height: frame.height)
                .onChange(of: isActive, initial: false) { oldValue, newValue in
                    let position = CGPoint(x: frame.midX, y: frame.midY)
                    if let coordinate = proxy.convert(position, from: .global), !newValue {
                        self.coordinate = coordinate
                        translation = .zero
                        onCoordinateChange(coordinate)
                    }
                }
        }
        .frame(width: 30, height: 30)
        .contentShape(.rect)
        .offset(translation)
        .gesture(
            LongPressGesture(minimumDuration: 0.15)
                .onEnded{
                    isActive = $0
                }
                .simultaneously(with:
                                    DragGesture(minimumDistance: 0)
                    .onChanged{ value in
                        if isActive { translation = value.translation }
                    }
                    .onEnded{ value in
                        if isActive { isActive = false }
                    }
                               )
        )
    }
}

/// Static values
extension MKCoordinateSpan {
    static var initialSpan: MKCoordinateSpan {
        return .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
    }
}

extension CLLocationCoordinate2D {
    static var merkez: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 38.347900, longitude: 38.301088)
    }
}
