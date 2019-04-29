//
//  MapUserLocationButton.swift
//  mapboxPerformanceIssues
//
//  Created by Marco Pappalardo on 29/04/2019.
//  Copyright © 2019 Marco Pappalardo. All rights reserved.
//

import Foundation
import UIKit

/// A Button Displaying a Icon on the Map
class MapUserLocationButton: UIButton {
    
    // MARK: - Structures
    
    enum TrackingState {
        case none
        case follow
        case followWithHeading
        
    }
    
    
    // MARK: - Public Vars
    
    /// Update the button UI configuration when tracking mode is changed.
    var trackingState: TrackingState = .none
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.30
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        setBackgroundImage(#imageLiteral(resourceName: "button"), for: .normal)
        setBackgroundImage(#imageLiteral(resourceName: "button"), for: .highlighted)
        
        // Reset the configuration to complete the setup
        trackingState = .none
    }
    
}
