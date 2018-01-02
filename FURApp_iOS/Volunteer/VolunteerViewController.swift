//
//  VolunteerViewController.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 12/4/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit

class VolunteerViewController: UIViewController, VolunteerViewProtocol {
    
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
    @IBOutlet weak var leaderButton: UIButton!
    @IBOutlet weak var volunteerButton: UIButton!
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = VolunteerPresenter(withService: VolunteerService())
        self.presenter.attach(view: self)
        self.presenter.load()
    }
    
    // MARK: - IBActions
    @IBAction func leaderButtonClick(_ sender: Any) {
        self.presenter.leaderAccessEvent()
    }
    
    // MARK: - VolunteerViewContract
    func display(data: VolunteerEventViewData) {
        loadingIndicator.stopAnimating()
        eventView.isHidden = false
        
        leaderButton.layer.cornerRadius = 30.0
        volunteerButton.layer.cornerRadius = 30.0
        
        eventNameLabel.text = data.name
    }
    
    func displayNoData() {
        self.loadingIndicator.stopAnimating()
        self.measureTreeButton.layer.cornerRadius = 30.0
        self.noEventView.isHidden = false
    }
    
    func displayNoNetwork() {
        self.internetConnectionLabel.isHidden = false
        displayNoData()
    }
    
    func requestLocationPermission() {
        let alert = UIAlertController(title: "Activa tu localización", message: "Para poder ser líder de equipo necesitamos saber que te encuentras en el evento. Dirígete a Ajustes -> FURApp y activa la localización. Aún puedes participar como voluntario.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func requestRegistration() {
        let alert = UIAlertController(title: "¡Regístrate!", message: "Para poder ser líder de equipo necesitas estar registrado. Navega a la sección de eventos y da click al botón para unirte.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func accessLeaderGranted() {
        let alert = UIAlertController(title: "Bienvenido Líder", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Gracias", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func accessLeaderDenied() {
        let alert = UIAlertController(title: "Estás muy lejos del evento", message: "Acércate más para convertirte en líder. Si no, puedes acceder como voluntario.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
