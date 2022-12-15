//
//  TimeView.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TimeView: UIView {
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "before"
        label.textColor = .black
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        self.addSubview(testLabel)
        testLabel.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
}
