//
//  ViewController.swift
//  BuyPOS
//
//  Created by Lucero Terrazas Cendejas on 7/21/20.
//  Copyright © 2020 Erika Lucero Terrazas Cendejas. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate,UICollectionViewDataSource{
   
    
    @IBOutlet weak var btnCleanPass: UIButton!
    @IBOutlet weak var btnClean: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionImg: UICollectionView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
   
    
    var product:Array<Any>?
    var databaseRT:DataBaseRealtime?
    var arrayImages = ["pos1","pos22","pos33","pos44"]
    var arrayText = ["El mejor punto de venta","SamsumPay","Scanner","Facturacion"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       btnClean.isHidden = true
       btnCleanPass.isHidden = true
       collectionImg.dataSource = self
       collectionImg.delegate = self
        title = "BuyPOS"
        pageControl.numberOfPages = arrayImages.count
       
    }

    
    func  textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 250), animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        return true
    }
    
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b") 
       print(textField.tag)
        switch textField.tag {
        case 0:
            if isBackSpace == -92{
                btnClean.isHidden = true
            }else{
                btnClean.isHidden = false
            }
        default:
            if isBackSpace == -92{
                btnCleanPass.isHidden = true
            }else{
                btnCleanPass.isHidden = false
            }
        }
        
        
        
        return true
    }
    
    
    @IBAction func btnClean_Action(_ sender: UIButton) {
        txtEmail.text = " "
        txtEmail.text = nil
        btnClean.isHidden = true
    }
    
    @IBAction func btnCleanPass_Act(_ sender: UIButton) {
        txtPassword.text = " "
        txtPassword.text = nil
        btnCleanPass.isHidden = true
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
    
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagePos", for: indexPath) as! ImageViewCell
    
        cell.imgPOS.image = UIImage(named: arrayImages [indexPath.row])
        cell.lblDescription.text = arrayText[indexPath.row]
        return cell
        }

        
    }



    
    


