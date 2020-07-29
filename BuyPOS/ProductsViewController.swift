//
//  ProductsViewController.swift
//  BuyPOS
//
//  Created by Lucero Terrazas Cendejas on 7/28/20.
//  Copyright © 2020 Erika Lucero Terrazas Cendejas. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    @IBOutlet weak var productViewCollection: UICollectionView!
    var products:Array<Any>?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        productViewCollection.dataSource = self
        productViewCollection.delegate = self
      // print(products!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellProduct", for: indexPath) as! ProductCell
        let productDictionary = products![indexPath.row] as! Dictionary<String, String>

        cell.lblProductName.text = productDictionary["ProductName"]
        cell.lblPrice.text = productDictionary["Price"]
        //print(arrayDic)
       
        
        return cell
    }
    
   
    }



