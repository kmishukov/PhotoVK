//
//  ViewController.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 01.06.2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet var authorizeButton: AuthorizeButton!
    @IBOutlet var textLabel: UILabel!
    
    var didLogIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        authorizationCheck()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func configureView() {
        view.backgroundColor = UIColor.blueVK
        authorizeButton.setTitle("Авторизация", for: .normal)
        authorizeButton.setTitleColor(UIColor.blueVK, for: .normal) 
        authorizeButton.setImage(#imageLiteral(resourceName: "2000px-VK.com-logo.svg-2"), for: .normal)
        authorizeButton.layer.backgroundColor = UIColor.buttonGray.cgColor
        authorizeButton.layer.cornerRadius = 20
    }
    
    func authorizationCheck() {
        if authorized != nil {
            print("Ready to perform segue to TableViewController")
            performSegue(withIdentifier: "showFriends", sender: nil)
        } else {
            print("No authorization detected.")
        }
    }
}

