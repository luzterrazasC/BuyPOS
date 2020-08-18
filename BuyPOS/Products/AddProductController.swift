//
//  AddProductController.swift
//  BuyPOS
//
//  Created by Lucero Terrazas Cendejas on 8/6/20.
//  Copyright © 2020 Erika Lucero Terrazas Cendejas. All rights reserved.
//

import UIKit
import Firebase
class AddProductController: UIViewController {

    @IBOutlet weak var txtProductName: UITextField!
    
    @IBOutlet weak var txtBarCode: UITextField!
    
    @IBOutlet weak var txtPrice: UITextField!
    
    @IBOutlet weak var txtStock: UITextField!
    var dataBase : DataBaseRealtime?
    var productVC : ProductsViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataBase = DataBaseRealtime()
        productVC = ProductsViewController()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(AddProductController.dismissViewControl))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:#selector(AddProductController.insertProduct))
        
    }
    
    @objc func dismissViewControl(){
        
        navigationController?.popViewController(animated: true)
      
       
    }

    @objc func insertProduct(){
        
        let productsDictionar =  ["ProductName":txtProductName.text!,
                                  "BarCode":txtBarCode.text!,
                                  "Price":txtPrice.text!,
                                  "Stock":txtStock.text!,
                                  "UserId":" "]
        
        let result  = dataBase!.insertDataBase(child: "Products", parameters: productsDictionar)
        print(result)
        
    productVC?.nuevoArraey(objet: productsDictionar)
    }
    
    
   
    

}

