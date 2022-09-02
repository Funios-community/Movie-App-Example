//
//  ProfileViewController.swift
//  Funios Animals
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class ProfileViewController: UIViewController {

    var username: String?
    
    @IBOutlet weak var labelUsername: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelUsername.text = username
    }

    @IBAction func onLogoutClick(_ sender: UIButton) {
        self.tabBarController?.dismiss(animated: true)
    }
    
}
