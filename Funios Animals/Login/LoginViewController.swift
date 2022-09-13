//
//  ViewController.swift
//  Funios Animals
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private let registeredUsername: String = "azam"
    private let registeredPassword: String = "pass"
    
    private let loggedInUserDefaultsKey = "com.funios.loggedInkey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isUserAlreadyLoggedIn()
        view.isHidden = false
    }
    
    private func isUserAlreadyLoggedIn() {
        if UserDefaults.standard.bool(forKey: loggedInUserDefaultsKey) {
           perfomSegueToMovieList()
        }
    }

    @IBAction func onLoginClick(_ sender: Any) {
        let inputedUsername = usernameTextField.text
        let inputedPassword = passwordTextField.text
        
        if inputedUsername == registeredUsername && inputedPassword == registeredPassword {
            saveIsUserLoggeedIn(userLoginSuccesfully: true)
            saveInputtedUsername(inputedUsername: inputedUsername!)
       
            perfomSegueToMovieList()
        } else {
            createAlertWrongCredentials()
        }
    }
    
    private func createAlertWrongCredentials() {
        let alertTitle = "Wrong Credentials"
        let alertMessage = "Your username or password is wrong"
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        show(alert, sender: nil)
    }
    
    private func perfomSegueToMovieList() {
        performSegue(withIdentifier: "segueToTabbar", sender: nil)
    }
    
    private func saveIsUserLoggeedIn(userLoginSuccesfully isLogin: Bool) {
        UserDefaults.standard.set(isLogin, forKey: loggedInUserDefaultsKey)
    }
    
    private func saveInputtedUsername(inputedUsername username: String) {
        let usernameUserdefaultsKey = "com.funios.usernameKey"
        UserDefaults.standard.set(username, forKey: usernameUserdefaultsKey)
    }
}

