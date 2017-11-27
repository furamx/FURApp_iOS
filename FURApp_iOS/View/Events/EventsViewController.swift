//
//  EventsViewController.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/15/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class EventsViewController: UIViewController, FUIAuthDelegate {
    
    // MARK: - Properties
    var eventsPresenter: EventsPresenter!
    var statusBarShouldBeHidden = false
    var eventsData: [Event]?
    var eventSelected: Event?
    
    // MARK: - IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var bottomInfoView: UIView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsPresenter = EventsPresenter()
        eventsPresenter.attachView(view: self)
        eventsPresenter.setupAuth()
        eventsPresenter.loadData()
        loadingActivityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        statusBarShouldBeHidden = false
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarShouldBeHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    // MARK: - IBActions
    @IBAction func openLoginButton(_ sender: UIButton) {
        eventsPresenter.openLogin()
    }
    
    @objc public func logOutAction(sender: UITapGestureRecognizer){
        eventsPresenter.logOut()
    }
    
    // MARK: - Firebase Authentication
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        guard let authError = error else { return }
        
        let errorCode = UInt((authError as NSError).code)
        
        switch errorCode {
        case FUIAuthErrorCode.userCancelledSignIn.rawValue:
            print("User cancelled sign-in");
            break
            
        default:
            let detailedError = (authError as NSError).userInfo[NSUnderlyingErrorKey] ?? authError
            print("Login error: \((detailedError as! NSError).localizedDescription)");
        }
    }
    
    // MARK: - UI Response Of Presenter
    func hideSignUpButton(){
        self.signUpButton.isEnabled = false
        self.signUpButton.setTitle("", for: .disabled)
        for constraint in self.bottomInfoView.constraints {
            if constraint.identifier == "bottomInfoViewConstraint" {
                constraint.constant = 0
            }
        }
        updateUI()
    }
    
    func showSignUpButton(){
        self.signUpButton.isEnabled = true
        
        for constraint in self.bottomInfoView.constraints {
            if constraint.identifier == "bottomInfoViewConstraint" {
                constraint.constant = 70
            }
        }
        updateUI()
    }
    
    func show(data: [Event]?) {
        configure(collectionView: eventCollectionView, data: data)
        loadingActivityIndicator.stopAnimating()
        loadingLabel.isHidden = true
        updateUI()
    }
    
    func updateUI(){
        self.view.layoutIfNeeded()
        self.eventCollectionView.reloadSections(IndexSet(0 ..< 1))
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "presentEvent") {
            let eventDetailPresenter = EventDetailPresenter()
            eventDetailPresenter.load(data: eventSelected)
            let eventDetailController = segue.destination as! EventDetailViewController
            eventDetailController.presenter = eventDetailPresenter
        }
    }
}
