//
//  ViewController.swift
//  TableView
//
//  Created by JustinZelus on 2019/2/18.
//  Copyright © 2019 JustinZelus. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var table: UITableView!
    var userInfo:[[String]] = [];
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView();
        v.backgroundColor = UIColor.clear;
        return v;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? MyTableViewCell {
 
            //外觀 - 圓角 + 陰影
            cell.contentView.layer.cornerRadius = 8
            cell.layer.masksToBounds = false
            cell.layer.shadowOffset = CGSize(width: 0, height: 6)
            cell.layer.shadowColor = UIColor.black.cgColor;
            cell.layer.shadowOpacity = 0.6
            cell.layer.shadowRadius = 4

            //資料
            cell.imgState.image = UIImage(named: "img_warning.png");
            cell.lblTitle.text = "警報器現況";
            if self.userInfo.isEmpty == false {
                cell.lblDate.text = self.userInfo[0][0] ;
            }
            else{
                cell.lblDate.text = "假資料......";
            }
            cell.lblState.text = "異常";
            
            return cell;
        }else {
            let cell = UITableViewCell()
            return cell;
        }
    }
    
    func getUserSituationFromApi(){
        let strURL: String = "http://104feixincm.iii.wpj.tw/maf/Event/se?fToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjAwMCIsIkFjYyI6InBlYW51dCIsImV4cCI6MTg2NjE5OTUxN30.OaXzewi49pqgwuASci6iB-cTbTuZsMfWVRpgqzkJSQk"
        
        let myUrl = URL(string: strURL);
        
        let mySessionConfig = URLSessionConfiguration.default;
        let mySession = URLSession(configuration: mySessionConfig, delegate: nil, delegateQueue: nil)
        
        var request = URLRequest(url: myUrl!);
        request.httpMethod = "POST";
        
        let myDataTask = mySession.dataTask(with: request, completionHandler: {
            (data: Data?,reponse:URLResponse?,error:Error?) -> Void in
            
            if error == nil {
                let statusCode = (reponse as! HTTPURLResponse).statusCode;
                print("http狀態馬:\(statusCode)");
                print("共下載:\(data!.count) bytes")
                
                if statusCode == 200 {
                    do {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) ;
                        
                        let json = [["目錄": "居家安全","群組": "A棟一樓之一","感應器名稱": "火災警報器", "時間": "2018-08-22 18:31:27"]]
                        
                        print(json);
//
//                        self.userInfo = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [[String]]
                        
//                        print(self.userInfo);
                        
                        DispatchQueue.main.async {
                            self.table.reloadData();
                        }
                        
//                        print(self.userInfo[0]);
                    }
                    catch {
                        print("解析錯誤:\(error)")
                    }
                }
            }else {
                print("錯誤:\(String(describing: error?.localizedDescription))");
            }
        });
        myDataTask.resume();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self;
        table.dataSource = self;

        getUserSituationFromApi();
    }


}

