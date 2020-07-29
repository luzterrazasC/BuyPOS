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
    var dataBaseRealtime:DataBaseRealtime?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        lblUserName.text = userName
        title = storeName
        dataBaseRealtime = DataBaseRealtime()
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
    let products:Dictionary<String,String> = ["UserId":uidUser!,
                                              "ProductName":txtProductName.text!,
                                              "BarCode":txtBarCode.text!,
                                              "Price":txtPrice.text!,
                                              "Stock":txtStock.text!]

     let result = dataBaseRealtime!.insertDataBase(child: "Products", parameters: products)
        print(result)
        
      
     //   let ref = Database.database().reference()
        //Agregar producto
       // ref.child("Store").setValue(["UserId":uidUser!,
         //                            "NameStore":storeName!,
           //                          "UserName":userName!])
        /*ref.child("Products").childByAutoId().setValue(["UserId":uidUser!,
                                        "ProductName":txtProductName.text!,
                                        "BarCode":txtBarCode.text!,
                                        "Price":txtPrice.text!,
                                        "Stock":txtStock.text!])*/
        
        
        
        
        //obtencion de datos
        /* ref.child("products").observeSingleEvent(of: .value){
         
         (snapshot)in
         let empoye  = snapshot.value as? [String:Any]
         print(empoye ?? "")
         }*/
        
        
        //eliminar
        //ref.child("products/-MCECUPsH-5P-tqfL2kd").removeValue()
        // Actualizar
        
        //Borrar
        
    }
    
    @IBAction func getProductsbtn(_ sender: UIButton) {
  getProducts(table: "Products")
    }
    func getProducts(table:String){
        let ref = Database.database().reference()
         var arrayDes:NSDictionary!
        ref.child(table).observeSingleEvent(of: .value) { (resultado) in
            arrayDes = (resultado.value as? NSDictionary)!
            
            let  productObj = Array(arrayDes.allValues)
            /* for value in productObj {
             let array = (value as! Dictionary<String,String>)*/
            
            
            print("Productos: \(productObj)")
            self.performSegue(withIdentifier: "segueProducts", sender:productObj)

        }
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueProducts"{
            let  produst = sender as! Array<Any>
           let obj: ProductsViewController = segue.destination as! ProductsViewController
               obj.products = produst
            
            
        }
    }
}
