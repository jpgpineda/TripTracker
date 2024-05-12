//
//  LoaderViewController.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import UIKit
import Lottie

class LoaderViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var animationContainerView: UIView!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        animationView = .init(name: Constants.loaderAnimation)
        animationView?.frame = animationContainerView.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationContainerView.addSubview(animationView ?? UIView())
        animationView?.play()
    }
}
