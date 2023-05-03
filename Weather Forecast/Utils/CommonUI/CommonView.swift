//
//  CommonView.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import UIKit

class CommonView: UIView {
    
    // MARK: - @IBInspectable
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateCornerRadius()
        }
    }
        
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: - Private Methods
    

    private func updateCornerRadius() {
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
