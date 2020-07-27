//
//  ViewController.swift
//  BuyPOS
//
//  Created by Lucero Terrazas Cendejas on 7/21/20.
//  Copyright © 2020 Erika Lucero Terrazas Cendejas. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BuyPOS"
    }

    
    
    @IBAction func btnRegister(_ sender: UIButton) {
        userAcces(typeLog: 1)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        userAcces(typeLog: 2)
    }
    
    func userAcces(typeLog:Int){

    if let email = txtEmail.text, let password = txtPassword.text {
        if typeLog == 1 {
            Auth.auth().createUser(withEmail:email, password:password) { (resul, errorLog) in
                if let resultado  = resul, errorLog == nil {
                    let userInfo = Auth.auth().currentUser
                    if userInfo != nil {
                        
                        let dataArray = [userInfo!.uid, userInfo!.email]

                        self.performSegue(withIdentifier: "segueRegister", sender:dataArray)
                    }else {
                        // No user is signed in.
                        // ...
                    }
                    
                }else{
                self.alert(messageError:errorLog!.localizedDescription)
   
                }
            }
            
        }else{
       
           Auth.auth().signIn(withEmail: email, password: password) {  (resul, errorLog) in
            if let resultado  = resul, errorLog == nil {
               let userInfo = Auth.auth().currentUser
                if userInfo != nil {
                    
                    let uid = userInfo!.uid

                   self.performSegue(withIdentifier: "segueHome", sender:uid)
                }else {
                    // No user is signed in.
                    // ...
                }
               
                
            }else{
                self.alert(messageError:errorLog!.localizedDescription)
                
            }
                }
           
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueRegister"{
            let  dateReceip = sender as! Array<String>
            let obj: RegisterViewController = segue.destination as! RegisterViewController
            obj.uiId = dateReceip[0]
            obj.email = dateReceip[1]
            
            txtEmail.text = ""
            txtPassword.text = ""
        }else {
            if segue.identifier == "segueHome"{
                let  uidUser = sender as! String
                let obj: HomeViewController = segue.destination as! HomeViewController
                obj.uidUser = uidUser

                txtEmail.text = ""
                txtPassword.text = ""
            }
            
        }
    }
        
        func alert(messageError:String){
            
            let alert = UIAlertController(title: "Error", message:messageError, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

