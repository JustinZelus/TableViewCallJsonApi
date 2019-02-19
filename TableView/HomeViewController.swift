//
//  HomeViewController.swift
//  TableView
//
//  Created by JustinZelus on 2019/2/19.
//  Copyright © 2019 JustinZelus. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var btnGO: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //按鈕外觀ㄎ
        self.btnGO.layer.cornerRadius = 8
        self.btnGO.layer.masksToBounds = false
        self.btnGO.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.btnGO.layer.shadowColor = UIColor.black.cgColor;
        self.btnGO.layer.shadowOpacity = 0.8
        self.btnGO.layer.shadowRadius = 5
        
        let file1 = "test"
        let file2 = "rightFormat"
        loadJsonFile(file: file1); //讀取專案底下的test.json檔案
    }
    
    func loadJsonFile(file: String) {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves);
            print("未轉換之前")
            print(json)
            
            let convertedString = String(data: data, encoding: String.Encoding.utf8)
            print("轉換utf8之後")
            print(convertedString!)
        } catch {
            print(error)
        }
    }
}
