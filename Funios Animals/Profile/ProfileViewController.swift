//
//  ProfileViewController.swift
//  Funios Animals
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var labelUsername: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUsernameAndSetItToWelcomeLabel()
    }
    
    private func getUsernameAndSetItToWelcomeLabel() {
        let usernameUserdefaultsKey = "com.funios.usernameKey"
        let savedUsername = UserDefaults.standard.string(forKey: usernameUserdefaultsKey)!
        labelUsername.text = "Hello, \(savedUsername)"
    }

    @IBAction func onLogoutClick(_ sender: UIButton) {
        self.tabBarController?.dismiss(animated: true)
        UserDefaults.standard.set(false, forKey: "com.funios.loggedInkey")
    }
    
}
