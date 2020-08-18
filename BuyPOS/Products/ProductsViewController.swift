//
//  ProductsViewController.swift
//  BuyPOS
//
//  Created by Lucero Terrazas Cendejas on 7/28/20.
//  Copyright © 2020 Erika Lucero Terrazas Cendejas. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{



  
    @IBOutlet weak var productViewCollection: UICollectionView!
    var products:Array<Any>?
    var database : DataBaseRealtime?
    override func viewDidLoad() {
        super.viewDidLoad()
        database = DataBaseRealtime()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(ProductsViewController.methodos))
        

        navigationItem.rightBarButtonItem?.tintColor = UIColor(white: 1, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        productViewCollection.dataSource = self
        productViewCollection.delegate = self

    }
 
    
  
    @objc func methodos() {
       // self.performSegue(withIdentifier: "segueAddProducts", sender: nil)
        let alerta = UIAlertController(title: "Agregar nuevo producto", message: " ", preferredStyle: .alert)
        
        
        let guardar = UIAlertAction(title: "Agregar", style: .default, handler: {
            
            (action:UIAlertAction) -> Void in

            let productName = alerta.textFields![0]
            let barCode = alerta.textFields![1]
            let price = alerta.textFields![2]
            let stock = alerta.textFields![3]
            let productsDictionar =  ["ProductName":productName.text!,
                                      "BarCode":barCode.text!,
                                      "Price":price.text!,
                                      "Stock":stock.text!,
                                      "UserId":" "]
            let resul  = self.database?.insertDataBase(child: "Products", parameters: productsDictionar)
            print(resul)
            //print(productName.text!)
           // print(barCode.text!)
            //print(price.text!)
            self.products!.append(productsDictionar)
            self.productViewCollection.reloadData()
        })
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .default)
        {(action: UIAlertAction) -> Void in }
        
        alerta.addTextField { (textFile1:UITextField) in
            textFile1.placeholder = "Nombre del producto"
        }
        alerta.addTextField { (textFile2:UITextField) in
            textFile2.placeholder = "Codigo de barras"
        }
        alerta.addTextField { (textFile3:UITextField) in
            textFile3.placeholder = "Precio"
        }
        alerta.addTextField { (textFile4:UITextField) in
            textFile4.placeholder = "Stock"
        }

        
        alerta.addAction(guardar)
        alerta.addAction(cancelar)
        
        
        
        present(alerta, animated: true, completion: nil)
        
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
      
        return products!.count
    }
    
    func nuevoArraey(objet:Any){
        
       //products?.append(objet)
        print(objet)
        //print(products!)
        products!.append(objet)
        //productViewCollection.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let productDictionary = products![indexPath.row] as! Dictionary<String, String>

        cell.lblProductName.text = productDictionary["ProductName"]
        cell.lblPrice.text = "$" + "\(productDictionary["Price"]!)"
      
        //print(arrayDic)
       
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let widthValue = (screenSize.width / 2.0 ) * 0.8
        return CGSize(width: widthValue, height: widthValue/2)
    }

  
    //espacios de contornos
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
   
    }



