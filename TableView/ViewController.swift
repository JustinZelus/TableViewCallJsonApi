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
    var myDatas = [[[String:Any]]]();
    
    
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
            if !self.myDatas.isEmpty {
                cell.lblDate.text = self.myDatas[0][0]["群組"] as? String ;
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
        let strURL: String = "http://104feixincm.iii.wpj.tw/maf/Event/se?fToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjAwMCIsIkFjYyI6InBlYW51dCIsImV4cCI6MTg2NjIwNjg2MX0.Pq8588KIGd-csaOgk9lL28xgXSOq1955QzsGQDUhZuc"
        
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
                        let result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [[[String:Any]]];
                        print(result);


                        self.myDatas = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [[[String:Any]]]
                        
                        print(self.myDatas);
                        
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

