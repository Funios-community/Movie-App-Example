//
//  ViewController.swift
//  Funios Animals
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onLoginClick(_ sender: Any) {
        performSegue(withIdentifier: "segueToTabbar", sender: "funios")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTabbar" {
            if let tabBar = segue.destination as? UITabBarController {
                tabBar.viewControllers?.forEach({ viewController in
                    if let profileVC = viewController as? ProfileViewController {
                        profileVC.username = "Hello, Funios"
                    }
                })
            }
           
        }
    }
}

