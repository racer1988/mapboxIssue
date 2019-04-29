import UIKit
import Mapbox


protocol MapViewControllerLocationDelegate: class {
    func mapChanged(trackingMode: MapUserLocationButton.TrackingState)
}

// MARK: - The Controller
class MapViewController: UIViewController
{
    // MARK: - Public Variables
    weak var delegate: MapViewControllerLocationDelegate?
    
    
    // MARK: - Outlets
    
    @IBOutlet private weak var mapView: MGLMapView!
    
    // MARK: - Private Variables
    
    private var mapEdgeInsets: UIEdgeInsets {
        let paddingPx = max(self.mapView.frame.size.width * 0.02, 15.0)
        return UIEdgeInsets(top: paddingPx,
                            left: paddingPx,
                            bottom: paddingPx,
                            right: paddingPx)
    }
    
    // MARK: - Init
    
    /// Creates a MapViewController
    ///
    /// - Parameter configuration: the initial configuration
    init() {
        super.init(nibName: String(describing: MapViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Accessibility
        mapView.isAccessibilityElement = true
        mapView.accessibilityLabel = NSLocalizedString("mapview", comment: "")
        
        mapView.delegate = self
        
        mapView.showsScale = true
        mapView.isZoomEnabled = true
        mapView.isRotateEnabled = true
        mapView.isScrollEnabled = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("[Map] viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[Map] viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("[Map] viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("[Map] viewDidDisappear")
    }
    
    
}


// MARK: - MGLMapViewDelegate
extension MapViewController: MGLMapViewDelegate {
    
    // MARK: - Responding to Map Position Changes
    
    func mapView(_ mapView: MGLMapView, regionWillChangeAnimated animated: Bool) {
        print("regionWillChangeAnimated")
        
    }
    
    
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        print("regionDidChangeAnimated")
        
    }
    
    
    // MARK: - Loading the Map
    
    func mapViewWillStartLoadingMap(_ mapView: MGLMapView) {
        print("mapViewWillStartLoadingMap")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        print("mapViewDidFinishLoadingMap")
        
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MGLMapView, withError error: Error) {
        print("mapViewDidFailLoadingMap")
              }
    
    func mapViewWillStartRenderingMap(_ mapView: MGLMapView) {
        print("mapViewWillStartRenderingMap")
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MGLMapView, fullyRendered: Bool) {
        print("mapViewDidFinishRenderingMap")
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        print("didFinishLoadingStyle")
        
    }
    
    
    // MARK: - Tracking User Location
    
    func mapViewWillStartLocatingUser(_ mapView: MGLMapView) {
        print("mapViewWillStartLocatingUser")
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MGLMapView) {
        print("mapViewDidStopLocatingUser")
    }
    
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        print("didUpdateUserLocation")
    }
    
    func mapView(_ mapView: MGLMapView, didFailToLocateUserWithError error: Error) {
        print("didFailToLocateUserWithError")
    }
    

    func mapView(_ mapView: MGLMapView,
                 didChange mode: MGLUserTrackingMode,
                 animated: Bool) {
        print("didChange MGLUserTrackingMode")
        
        switch (mode) {
        case .none:
            delegate?.mapChanged(trackingMode: .none)
        case .follow:
            delegate?.mapChanged(trackingMode: .follow)
        case .followWithHeading:
            delegate?.mapChanged(trackingMode: .followWithHeading)
        case .followWithCourse:
            assertionFailure("We dont support Course yet")
            // the tracking state should look the same
            delegate?.mapChanged(trackingMode: .followWithHeading)
        @unknown default:
            assertionFailure()
            delegate?.mapChanged(trackingMode: .none)
        }
        
        
    }

    
}

// MARK: - User Location Button
extension MapViewController {
    
    
    func stopFollowingUserLocation() {
        mapView.resetNorth()
        mapView.userTrackingMode = .none
    }
    
    func followUserLocation() {
        mapView.userTrackingMode = .follow
    }
    
    func followUserLocationWithHeading() {
        mapView.userTrackingMode = .followWithHeading
    }
    
    func followUserLocationWithCourse() {
        mapView.userTrackingMode = .followWithCourse
    }
    
    
}


