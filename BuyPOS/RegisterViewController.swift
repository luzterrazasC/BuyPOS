//
//  RegisterViewController.swift
//  BuyPOS
//
//  Created by Lucero Terrazas Cendejas on 7/21/20.
//  Copyright © 2020 Erika Lucero Terrazas Cendejas. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    var uiId:String?
    var email:String?
    var displayName: String?
    var nameStore:String?
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNameStore: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registro"
         userInfo()
    }
    
    func userInfo(){
        txtName.text = displayName
        txtEmail.text = email
        print(uiId!)
    }
   
    @IBAction func btnUserSave(_ sender: UIButton) {
       
        let  dataUser = [txtName.text!, uiId!, txtNameStore.text!]
        
        let ref = Database.database().reference()
        //Agregar tienda
        ref.child("Store").child("\(uiId!)").setValue(["NameStore" :nameStore!,
                                                        "UserName":displayName!])
       
           self.performSegue(withIdentifier: "segueRegisterHome", sender:dataUser)
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueRegisterHome"{
            let  user = sender as! Array<String>
            let obj: HomeViewController = segue.destination as! HomeViewController
            obj.userName = user[0]
            obj.uidUser = user[1]
            obj.storeName = user[2]
            
            txtName.text = ""
            txtNameStore.text = ""
            txtEmail.text = ""
            
            
        }
    }
    
}
