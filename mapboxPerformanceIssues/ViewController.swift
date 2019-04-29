//
//  ViewController.swift
//  mapboxPerformanceIssues
//
//  Created by Marco Pappalardo on 29/04/2019.
//  Copyright © 2019 Marco Pappalardo. All rights reserved.
//

import UIKit
import PureLayout

class ViewController: UIViewController {

    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var locationButtonContainer: UIView!
    
    private lazy var mapViewController: MapViewController = {
        let mapViewController = MapViewController()
        mapViewController.delegate = self
        return mapViewController
    }()
    
    private lazy var locationButtonViewController: LocationButtonViewController = {
        
        let configuration: [MapUserLocationButton.TrackingState] = [
            .none,
            .follow,
            .followWithHeading
        ]
        
        let locationButtonViewController = LocationButtonViewController(configuration: configuration)
        locationButtonViewController.delegate = self
        return locationButtonViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        add(child: mapViewController, on: mapContainer)
        add(child: locationButtonViewController, on: locationButtonContainer)
    }

    func add(child: UIViewController, on view: UIView) {
        self.addChild(child)
        view.addSubview(child.view)
        child.view.autoPinEdgesToSuperviewEdges()
        
        child.didMove(toParent: self)
    }
    
}

extension ViewController: MapViewControllerLocationDelegate {
    func mapChanged(trackingMode: MapUserLocationButton.TrackingState) {
        locationButtonViewController.configure(with: trackingMode)
    }
    
}

extension ViewController: LocationButtonViewControllerDelegate {
    func didSet(trackingState: MapUserLocationButton.TrackingState) {
        switch trackingState {
        case .none:
            mapViewController.stopFollowingUserLocation()
            
        case .follow:
            mapViewController.followUserLocation()
            
        case .followWithHeading:
            mapViewController.followUserLocationWithHeading()
        }
    }
    
    
}

////
/// A View that only forwards click events to the subviews
/// Else it sends them through, like it is really transparent
class PassThroughView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        for subview in subviews {
            if !subview.isHidden &&
                subview.isUserInteractionEnabled &&
                subview.point(inside: convert(point,
                                              to: subview),
                              with: event) {
                return true
            }
        }
        return false
    }
}

