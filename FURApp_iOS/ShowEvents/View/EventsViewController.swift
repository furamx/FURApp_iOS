//
//  EventsViewController.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/15/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class EventsViewController: UIViewController, FUIAuthDelegate, EventsViewProtocol {
    
    // MARK: - Properties
    var eventsPresenter: EventsPresenter!
    var statusBarShouldBeHidden = false
    var eventsData: [EventsViewData]?
    var eventSelected: EventsViewData?
    
    // MARK: - IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var bottomInfoView: UIView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var warningInternetImageView: UIImageView!
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsPresenter = EventsPresenter(withService: EventsService())
        eventsPresenter.attach(view: self)
        eventsPresenter.load()
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
    
    func showSignIn(controller: Any){
        present(controller as! UIViewController, animated: true, completion: nil)
    }
    
    func display(data: [EventsViewData]?) {
        eventsData = data
        configure(collectionView: eventCollectionView, data: data)
        loadingActivityIndicator.stopAnimating()
        loadingLabel.isHidden = true
        updateUI()
    }
    
    func displayNoNetwork() {
        warningInternetImageView.isHidden = false
        loadingActivityIndicator.stopAnimating()
        loadingLabel.text = "No tienes una conexión a internet"
    }
    
    func showGoodbyeMessage() {
        let alert = UIAlertController(title: "¡Adiós!", message: "Esperamos verte pronto", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UI logic
    func updateUI(){
        self.view.layoutIfNeeded()
        self.eventCollectionView.reloadSections(IndexSet(0 ..< 1))
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarShouldBeHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "presentEvent") {
            let eventDetailPresenter = EventDetailPresenter()
            eventDetailPresenter.load(data: eventsPresenter.getSelectedEvent())
            
            let eventDetailController = segue.destination as! EventDetailViewController
            eventDetailController.presenter = eventDetailPresenter
        }
    }
}
