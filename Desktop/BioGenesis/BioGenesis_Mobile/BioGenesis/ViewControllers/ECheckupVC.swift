//
//  ECheckupVC.swift
//  BioGenesis
//
//  Created by Martin on 20/07/2022.
//

import UIKit

class ECheckupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    func setupScreen() {
        
        //MARK: Top View - Search Bar & Back Buttom
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 20, y: 50, width: 30, height: 30)
        backBtn.backgroundColor = .black
        backBtn.addTarget(self, action: #selector(backBtnPressed(_:)), for: .touchUpInside)
        
        view.addSubview(backBtn)
    
    }
    
    
    //----------------MARK: Actions----------------
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
