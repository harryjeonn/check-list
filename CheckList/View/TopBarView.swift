//
//  TopBarView.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/17.
//

import UIKit

class TopBarView: UIView {
    let titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "제목"
        lbl.font = .boldSystemFont(ofSize: 17)
        
        return lbl
    }()
    
    let leftButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("left", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        return btn
    }()
    
    let rightButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("right", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        return btn
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
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(12)
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-12)
        }
    }
}
