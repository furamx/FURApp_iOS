//
//  VolunteerViewController.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 12/4/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit

class VolunteerViewController: UIViewController {
    
    // MARK: - Properties
    private var presenter: VolunteerPresenter!
    
    // MARK: - IBOutlets
    @IBOutlet var noEventView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: No event view outlets
    @IBOutlet weak var internetConnectionLabel: UILabel!
    @IBOutlet weak var noEventsLabel: UILabel!
    @IBOutlet weak var noEventsImage: UIImageView!
    @IBOutlet weak var learnAboutLabel: UILabel!
    @IBOutlet weak var measureTreeButton: UIButton!
    
    // MARK: Event view outlets
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var accessButton: UIButton!
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = VolunteerPresenter()
        self.presenter.attach(view: self)
        
        if (ConnectionHelper.isConnectedToNetwork()){
            self.presenter.loadData()
        }else {
            internetConnectionLabel.isHidden = false
            self.displayNoData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayNoData() {
        self.loadingIndicator.stopAnimating()
        self.measureTreeButton.layer.cornerRadius = 30.0
        self.noEventView.isHidden = false
    }
    
    func display(data: Event) {
        self.loadingIndicator.stopAnimating()
        self.eventView.isHidden = false
        accessButton.layer.cornerRadius = 30.0
        eventNameLabel.text = data.name
    }
}
