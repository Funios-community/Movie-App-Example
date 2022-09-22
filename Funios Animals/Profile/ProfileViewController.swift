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
        UserDefaults.standard.set(false, forKey: "com.funios.loggedInkey")
        self.present(makeLoginViewController(), animated: true)
    }
    
    private func makeLoginViewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let videoController = storyboard.instantiateInitialViewController() as! LoginViewController
        videoController.modalPresentationStyle = .fullScreen
        return videoController
    }
}
