//
//  EventDetailViewController.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/15/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit
import MapKit

class EventDetailViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Properties
    var presenter: EventDetailPresenter?
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet var locationMapView: MKMapView!
    @IBOutlet weak var assistButtonView: UIView!
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assistButtonView.layer.cornerRadius = 14.0
        presenter?.attach(view: self)
        presenter?.show()
    }
    
    // MARK: - IBActions
    @IBAction func closeButtonDidPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARk: - Preferences
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
