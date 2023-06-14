//
//  LocationDetailViewController.swift
//  Rick & Morty
//
//  Created by Admin on 11.06.2023.
//

import UIKit

class LocationDetailViewController: UIViewController {

    let model : ResultLocation?

    init(model: ResultLocation?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let color = UIColor(named: "blue")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = color
    }
    func UISetup(){
    }
    
    func makeConstr() {
        
    }
}
