import UIKit
import MapboxMaps
import SwiftUI
import CoreLocation
//protocol UIViewControllerRepresentable : View where Self.Body == Never

struct MapBoxMapView: UIViewControllerRepresentable {
     
    func makeUIViewController(context: Context) -> MapViewController {
           return MapViewController()
       }
      
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
    }
}

public class MapViewController: UIViewController {
    //var locationManager = CLLocationManager()
    internal var mapView: MapView!
    //internal var cameraLocationConsumer: CameraLocationConsumer!
   // internal let toggleBearingImageButton: UIButton = UIButton(frame: .zero)

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Set initial camera settings
        let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: 40.83647410051574, longitude: 14.30582273457794), zoom: 4.5, pitch: 45)
        let myResourceOptions = ResourceOptions(accessToken: "sk.eyJ1IjoiZGpiYXVlciIsImEiOiJjbDg4YWZjNWoxMTM2M25tY282bG1uejBwIn0.hpNYu54sSOse9YmXzp9DGw")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, cameraOptions: cameraOptions, styleURI: StyleURI.dark)
               
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        // Setup and create button for toggling show bearing image
        mapView.location.delegate = self
        mapView.location.options.activityType = .other
        mapView.location.options.puckType = .puck2D()
        mapView.location.locationProvider.startUpdatingLocation()
        mapView.mapboxMap.onNext(event: .mapLoaded) { [self]_ in
            self.locationUpdate(newLocation: mapView.location.latestLocation!)
              }
        }
    }
extension MapViewController: LocationPermissionsDelegate, LocationConsumer {
    public func locationUpdate(newLocation: Location) {
        mapView.camera.fly(to: CameraOptions(center: newLocation.coordinate, zoom: 14.0), duration: 5.0)
    }
}

//    @objc func showHideBearingImage() {
//        showsBearingImage.toggle()
//    }
//
//    func syncPuckAndButton() {
//        // Update puck config
//        let configuration = Puck2DConfiguration.makeDefault(showBearing: showsBearingImage)
//
//        mapView.location.options.puckType = .puck2D(configuration)
//
//        // Update button title
//        let title: String = showsBearingImage ? "Hide bearing image" : "Show bearing image"
//        toggleBearingImageButton.setTitle(title, for: .normal)
//    }

//}

// Create class which conforms to LocationConsumer, update the camera's centerCoordinate when a locationUpdate is received
//public class CameraLocationConsumer: LocationConsumer {
//    weak var mapView: MapView?
//
//    init(mapView: MapView) {
//        self.mapView = mapView
//    }
//
//    public func locationUpdate(newLocation: Location) {
//        mapView?.camera.ease(
//            to: CameraOptions(center: newLocation.coordinate, zoom: 15),
//            duration: 1.3)
//    }
//}
