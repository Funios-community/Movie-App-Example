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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        AuthSingleton.instance.saveUserLogin(isLogin: isLogin)
    }
    
    private func saveInputtedUsername(inputedUsername username: String) {
        AuthSingleton.instance.saveUserName(name: username)
    }
}

