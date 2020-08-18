//
//  DataBase.swift
//  BuyPOS
//
//  Created by Lucero Terrazas Cendejas on 7/27/20.
//  Copyright © 2020 Erika Lucero Terrazas Cendejas. All rights reserved.
//

import Foundation
import Firebase

class DataBaseRealtime{
    
 var ref = Database.database().reference()
    
    func connectionDB() {
        
    }
    
    
    func insertDataBase(child:String,
                       parameters:Dictionary<String, String>
        ) -> Bool {
                ref.child(child).childByAutoId().setValue(parameters)
        
         return true
        }
    

   func getData(child: String)->Bool{
      
        var arrayDes:NSDictionary!
       
            ref.child(child).observeSingleEvent(of: .value) { (resultado) in
                arrayDes = (resultado.value as? NSDictionary)!
          
              let  productObj = Array(arrayDes.allValues)
               /* for value in productObj {
                    let array = (value as! Dictionary<String,String>)*/
                    
                    
                   // print("Productos: \(productObj)")
                
               
        //}
       
    }
      return  true
    }
           /* for value in array {
                let arr = (value as! [String : String])
                print("Nombre de la Llave: \(arr)")
            }*/
    func getProducts(table:String) ->NSDictionary{
       
            var arrayDes:NSDictionary!
            let ref = Database.database().reference()
            ref.child(table).observeSingleEvent(of: .value) { (resultado) in
                arrayDes = (resultado.value as? NSDictionary)!
                
    //let productObj = Array(arrayDes.allValues)
            
        }
        return arrayDes
    }
    
    
}


