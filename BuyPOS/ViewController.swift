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
    var product:Array<Any>?
    var databaseRT:DataBaseRealtime?
    
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
    
   //Autentificadion del usuario
    func userAcces(typeLog:Int){
//TypeLog  1  registrar usuario
    if let email = txtEmail.text, let password = txtPassword.text {
        if typeLog == 1 {
            Auth.auth().createUser(withEmail:email, password:password) { (resul, errorLog) in
                if  resul != nil, errorLog == nil {
                    let userInfo = Auth.auth().currentUser
                    if userInfo != nil {
                        
                        let dataArray = [userInfo!.uid, userInfo!.email]

                        self.performSegue(withIdentifier: "segueRegister", sender:dataArray)
                    }else {
                        
                    }
                    
                }else{
                self.alert(messageError:errorLog!.localizedDescription)
   
                }
            }
// TypeLog  2 ingresar
        }else{
       
           Auth.auth().signIn(withEmail: email, password: password) {  (resul, errorLog) in
            if resul != nil, errorLog == nil {
               let userInfo = Auth.auth().currentUser
                if userInfo != nil {
                    
                    let uid = userInfo!.uid

                   self.performSegue(withIdentifier: "segueHome", sender:uid)
                }else {

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
    
    
    
    @IBAction func btnPrueba(_ sender: UIButton) {
        
        databaseRT = DataBaseRealtime()
        let dicttionary = databaseRT!.getData(child: "Products")
        
     
       
        
        /*for value in products {
            let array = (value as! [String : String])
            print("Nombre de la Llave: \(array)")*/
            
            
        }
        
    }



    
    


