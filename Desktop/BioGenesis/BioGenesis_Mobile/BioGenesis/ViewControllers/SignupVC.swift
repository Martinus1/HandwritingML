//
//  SignupVC.swift
//  BioGenesis
//
//  Created by Martin on 12/08/2022.
//

import UIKit
import Amplify

class SignupVC: UIViewController {

    var bottomConstraint: NSLayoutConstraint?
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmationTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let emailBox = UIView()
        emailBox.frame = CGRect(x: 12, y: 200, width: screenSize.width - 24, height: 50)
        emailBox.layer.cornerRadius = 8
        emailBox.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2973879378)
        
        view.addSubview(emailBox)
    
        emailTextField.frame = CGRect(x: 12, y: 0, width: emailBox.frame.width - 24, height: 50)
        emailTextField.textAlignment = .left
        emailTextField.placeholder = "Email"
        emailTextField.tintColor  = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
//        emailTextField.font = UIFont(name: "Quicksand-Regular", size: 17)
        emailTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emailTextField.autocorrectionType = .no
//        passwordTextField.delegate = self
        //emailTxtField.addTarget(self, action: #selector(GoalCellOne.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        emailBox.addSubview(emailTextField)
        
        let passwordBox = UIView()
        passwordBox.frame = CGRect(x: 12, y: 270, width: screenSize.width - 24, height: 50)
        passwordBox.layer.cornerRadius = 8
        passwordBox.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2973879378)
         
        view.addSubview(passwordBox)
        
        passwordTextField.frame = CGRect(x: 12, y: 0, width: passwordBox.frame.width - 24, height: 50)
        passwordTextField.textAlignment = .left
        passwordTextField.placeholder = "Password"
        passwordTextField.tintColor  = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
//        passwordTextField.font = UIFont(name: "Quicksand-Regular", size: 17)
        passwordTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordTextField.autocorrectionType = .no
//        passwordTextField.delegate = self
        passwordTextField.textContentType = .password
        //emailTxtField.addTarget(self, action: #selector(GoalCellOne.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        passwordBox.addSubview(passwordTextField)
                
        
        let signUpButton = UIButton()
        signUpButton.frame = CGRect(x: 12, y: screenSize.height - 150, width: screenSize.width - 24, height: 50)
        signUpButton.backgroundColor = .black
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        view.addSubview(signUpButton)
        
        let signInButton = UIButton()
        signInButton.frame = CGRect(x: 12, y: screenSize.height - 80, width: screenSize.width - 24, height: 50)
        signInButton.backgroundColor = .black
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        view.addSubview(signInButton)
        
        //CONFIRMATION
        
        let confirmationBox = UIView()
        confirmationBox.frame = CGRect(x: 12, y: 350, width: screenSize.width - 24, height: 50)
        confirmationBox.layer.cornerRadius = 8
        confirmationBox.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2973879378)
         
        view.addSubview(confirmationBox)
        
        confirmationTextField.frame = CGRect(x: 12, y: 0, width: passwordBox.frame.width - 24, height: 50)
        confirmationTextField.textAlignment = .left
        confirmationTextField.placeholder = "Confirmation Code"
        confirmationTextField.tintColor  = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
//        passwordTextField.font = UIFont(name: "Quicksand-Regular", size: 17)
        confirmationTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        confirmationTextField.autocorrectionType = .no
//        passwordTextField.delegate = self
        confirmationTextField.textContentType = .password
        //emailTxtField.addTarget(self, action: #selector(GoalCellOne.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        confirmationBox.addSubview(confirmationTextField)
                
        
        let confirmationButton = UIButton()
        confirmationButton.frame = CGRect(x: 12, y: screenSize.height - 230, width: screenSize.width - 24, height: 50)
        confirmationButton.backgroundColor = .black
        confirmationButton.setTitle("Confirm", for: .normal)
        confirmationButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
        view.addSubview(confirmationButton)
        
        let checkStatusButton = UIButton()
        checkStatusButton.frame = CGRect(x: 12, y: screenSize.height - 300, width: screenSize.width - 24, height: 50)
        checkStatusButton.backgroundColor = .black
        checkStatusButton.setTitle("Check Status", for: .normal)
        checkStatusButton.addTarget(self, action: #selector(checkStatus), for: .touchUpInside)
        
        view.addSubview(checkStatusButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
      
    }

    @IBAction func signUp() {
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: email, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    @IBAction func confirm() {
        Amplify.Auth.confirmSignUp(for: emailTextField.text ?? "", confirmationCode: confirmationTextField.text ?? "") { result in
            switch result {
            case .success(let confirmResult):
                print(confirmResult)
                self.signIn()
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    @IBAction func signIn() {
        Amplify.Auth.signIn(username: emailTextField.text ?? "", password: passwordTextField.text ?? "") { result in
            switch result {
            case .success(let signInResult):
                print(signInResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func checkStatus() {
        Amplify.Auth.fetchAuthSession { result in
            print(result)
        }
        
    }
    
    //
    //Handle Keyboard
    //
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}
