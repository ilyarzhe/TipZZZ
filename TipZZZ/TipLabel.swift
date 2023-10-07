//
//  TipLabel.swift
//  TipZZZ
//
//  Created by Ilya Rzheznikov on 24/09/2023.
//

import UIKit

class TipLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override init (frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init (fontSize:CGFloat) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: fontSize, weight: .medium)
        self.textColor = .systemGray3
            
    }
}
