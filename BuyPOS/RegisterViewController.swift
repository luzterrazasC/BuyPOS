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
    var dataBaseRealtime:DataBaseRealtime?
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNameStore: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registro"
        dataBaseRealtime = DataBaseRealtime()
         userInfo()
    }
    
    func userInfo(){
        txtName.text = displayName
        txtEmail.text = email
        txtNameStore.text = nameStore
    }
   
    @IBAction func btnUserSave(_ sender: UIButton) {
     //  userInfo()
    let  dataUser = [txtName.text!, uiId!, txtNameStore.text!]
    let store:Dictionary<String,String> = ["NameStore" :txtNameStore.text!,
                                           "UserName":txtName.text!,
                                            "UiId": uiId!]
        
   let result = dataBaseRealtime!.insertDataBase(child: "Store", parameters: store)
          self.performSegue(withIdentifier: "segueRegisterHome", sender:dataUser)
        print(result)
       // let ref = Database.database().reference()
        //Agregar tienda
       /* ref.child("Store").childByAutoId().setValue(["NameStore" :txtNameStore.text!,
                                                         "UserName":txtName.text!,
                                                         "UiId": uiId!])*/
       
        
        
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
