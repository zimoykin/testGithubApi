//
//  AuthViewController.swift
//  testGithubApi
//
//  Created by Дмитрий on 07.09.2020.
//  Copyright © 2020 DZ. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func signInTouched(_ sender: UIButton) {
      
        if let login = loginField.text, let password = passwordField.text {
            
            NetworkManager.checkAccessGitHub (login, password) { accessApprove in
                if accessApprove {
                    
                }
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
