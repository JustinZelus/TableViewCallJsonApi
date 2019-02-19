//
//  MyTableViewCell.swift
//  TableView
//
//  Created by JustinZelus on 2019/2/18.
//  Copyright © 2019 JustinZelus. All rights reserved.
//

import UIKit

class MyTableViewCell : UITableViewCell {
    
    @IBOutlet weak var imgState: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblState: UILabel!
    
    override var frame: CGRect {
        didSet {
            //修改cell的左右間距20;
            var newFrame = frame;
            newFrame.origin.x = 20;
            newFrame.size.width -= 2 * newFrame.origin.x;
            super.frame = newFrame;
          
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //修改cell為圓角形狀ㄎ
        self.layer.cornerRadius = 8;
    }
}
