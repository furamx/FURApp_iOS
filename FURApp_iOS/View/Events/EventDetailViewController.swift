//
//  EventDetailViewController.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/15/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Properties
    @IBOutlet var detailScrollView: UIScrollView!
    @IBOutlet weak var assistView: UIView!

    //MARK: - ViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.8) {
            self.assistView.roundCorners(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 14.0)
            self.detailScrollView.roundCorners(corners: [.topRight, .topLeft], radius: 25.0)
        }
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
