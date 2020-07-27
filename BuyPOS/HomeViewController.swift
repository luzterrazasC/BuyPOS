//
//  HomeViewController.swift
//  BuyPOS
//
//  Created by Lucero Terrazas Cendejas on 7/21/20.
//  Copyright © 2020 Erika Lucero Terrazas Cendejas. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtProductName: UITextField!
    
    @IBOutlet weak var txtBarCode: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    
    @IBOutlet weak var txtStock: UITextField!
    
    var uidUser:String?
    var storeName:String?
    var userName:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        lblUserName.text = userName
        title = storeName
        accesStore(id: uidUser!)

    }
    
    func accesStore(id:String)  {
        let ref = Database.database().reference()

        ref.child("Store/UserId").observeSingleEvent(of: .value){
         
         (snapshot)in
         let empoye  = snapshot.value as? [String:Any]
         print(empoye ?? "")
         }
    }
    
    @IBAction func btnAddProduct(_ sender: UIButton) {
        addProduct()
        
    }
    func addProduct(){
        let ref = Database.database().reference()
        //Agregar producto
       // ref.child("Store").setValue(["UserId":uidUser!,
         //                            "NameStore":storeName!,
           //                          "UserName":userName!])
        ref.child("Products").childByAutoId().setValue(["UserId":uidUser!,
                                        "ProductName":txtProductName.text!,
                                        "BarCode":txtBarCode.text!,
                                        "Price":txtPrice.text!,
                                        "Stock":txtStock.text!])
        
        // Actualizar
        
        //Borrar
        
    }
    
}
