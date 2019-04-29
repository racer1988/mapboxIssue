import UIKit



protocol LocationButtonViewControllerDelegate: class {
    
    func didSet(trackingState: MapUserLocationButton.TrackingState)
}


class LocationButtonViewController: UIViewController {

    // MARK: - Public Vars
    weak var delegate: LocationButtonViewControllerDelegate?
    
    // MARK: - Private Vars
    
    private var configuration: [MapUserLocationButton.TrackingState]
    
    // MARK: - Outlets
    
    /// The location button
    @IBOutlet private weak var userLocationButton: MapUserLocationButton!
    @IBOutlet private weak var userLocationButtonBottomSpacing: NSLayoutConstraint!
    
    // MARK: - Init
    
    init(configuration: [MapUserLocationButton.TrackingState]) {
        
        // initialization checks:
        
        // MGLUserTrackingModeFollow
        // This tracking mode falls back to `MGLUserTrackingModeNone`
        if configuration.contains(.follow) {
            assert(configuration.contains(.none), "Violating MapBox state requirement. Check MGLUserTrackingMode")
        }
        
        // MGLUserTrackingModeFollowWithHeading
        // this tracking mode will fall back to `MGLUserTrackingModeFollow`.
        if configuration.contains(.followWithHeading) {
            assert(configuration.contains(.follow), "Violating MapBox state requirement. Check MGLUserTrackingMode")
        }
        
        // MGLUserTrackingModeFollowWithCourse
        // this tracking mode will fall back to `MGLUserTrackingModeFollow`.
        // Not yet implemented
        
        
        self.configuration = configuration
        super.init(nibName: String(describing: LocationButtonViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life
    

    /// Handle actions on the button tapped
    ///
    /// - Parameter sender: the button pressed
    @IBAction private func locationButtonTapped(_ sender: MapUserLocationButton) {
        nextState()
    }
    
    // MARK: - API
    
    /// Set the next possible state for the button in this configuration
    ///
    /// - Note: This will wrap around the possible states
    private func nextState() {
        
        guard let currentIndex = configuration.firstIndex(of: userLocationButton.trackingState) else {
            assertionFailure("Current state is not part of this configuration. You must provide a state that matches the current configuration")
            return
        }
        var nextIndex = currentIndex + 1
        // If we get to the last state, we wrap around
        nextIndex = configuration.indices.contains(nextIndex) ? nextIndex : 0
        // Get the new state
        let newState = configuration[nextIndex]
        // Set it
        configure(with: newState)
    }
    
    
    /// Set the state of the button to the provided one, if it is in the configuration of the button
    ///
    /// - Parameter state: the state to set
    func configure(with state: MapUserLocationButton.TrackingState) {
        guard configuration.firstIndex(of: state) != nil else {
            assertionFailure("Current state is not part of this configuration. You must provide a state that matches the current configuration")
            return
        }
        
        // Sets the status of the button
        userLocationButton.trackingState = state
        
        // execute the corresponding action
        delegate?.didSet(trackingState: state)
        
    }
    
    
    
}
