//
//  RegisterViewController.swift
//  BuyPOS
//
//  Created by Lucero Terrazas Cendejas on 7/21/20.
//  Copyright © 2020 Erika Lucero Terrazas Cendejas. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController, UITextFieldDelegate{

    var uiId:String?
    var email:String?
    var displayName: String?
    var nameStore:String?
    var dataBaseRealtime:DataBaseRealtime?
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNameStore: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var btnClose1: UIButton!
    @IBOutlet weak var btnClose2: UIButton!
    @IBOutlet weak var btnClose3: UIButton!
    @IBOutlet weak var btnClose4: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registro de Tienda"
        navigationItem.setHidesBackButton(true, animated: false)
        btnClose1.isHidden = true
        btnClose2.isHidden = true
        btnClose3.isHidden = true
        btnClose4.isHidden = true
        dataBaseRealtime = DataBaseRealtime()
        userInfo()
    }
    
    func userInfo(){
        txtName.text = displayName
        txtEmail.text = email
        txtNameStore.text = nameStore
    }
   
    @IBAction func btnUserSave(_ sender: UIButton) {
   

    let store:Dictionary<String,String> = ["NameStore":txtNameStore.text!,
                                           "UserName":txtName.text!,
                                            "UiId": uiId!]
       
    
   let result = dataBaseRealtime!.insertDataBase(child: "Store", parameters: store)
        
        getProducts()
    }
    
    func getProducts() {
         var arrayDes:NSDictionary!
        let ref = Database.database().reference()
        ref.child("Products").observeSingleEvent(of: .value) { (resultado) in
            arrayDes = (resultado.value as? NSDictionary)!
            
            let  productObj = Array(arrayDes.allValues)
            self.performSegue(withIdentifier: "segueRegisterHome", sender:productObj)
        }
    }

    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueRegisterHome"{
            let  products = sender as! Array<Any>

            let obj: ProductsViewController = segue.destination as! ProductsViewController
           // obj.userName = user[0]
            //obj.uidUser = user[1]
           // obj.storeName = user[2]
            obj.products = products
            txtName.text = ""
            txtNameStore.text = ""
            txtEmail.text = ""
            
            
        }
    }
    

    
  
 //control de botones de borrar
    
    @IBAction func btnClose1_Click(_ sender: UIButton) {
        txtEmail.text = " "
        btnClose1.isHidden = true
    }
    
    @IBAction func btnClose2_Click(_ sender: UIButton) {
        txtName.text = " "
         btnClose2.isHidden = true
    }
    
    @IBAction func btnClose3_Click(_ sender: UIButton) {
        txtNameStore.text = " "
         btnClose3.isHidden = true
    }
    
    @IBAction func btnClose4_Click(_ sender: UIButton) {
        txtAddress.text = " "
         btnClose4.isHidden = true
    }
    func  textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 10,y: 110), animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtAddress.resignFirstResponder()
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        print(textField.tag)
        switch textField.tag {
        case 0:
            if isBackSpace == -92{
                btnClose1.isHidden = true
            }else{
                btnClose1.isHidden = false
            }
        case 1:
            if isBackSpace == -92{
                btnClose2.isHidden = true
            }else{
                btnClose2.isHidden = false
            }
        case 2:
            if isBackSpace == -92{
                btnClose3.isHidden = true
            }else{
                btnClose3.isHidden = false
            }
    
        default:
            if isBackSpace == -92{
                btnClose4.isHidden = true
            }else{
                btnClose4.isHidden = false
            }
        }
        
        
        
        return true
    }
    
}
