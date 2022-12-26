//
//  TimeView.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/15.
//

import UIKit
import SnapKit

class TimeView: UIView {
    let alarmImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(systemName: "alarm")
        imgView.tintColor = .black
        
        return imgView
    }()
    
    let timeText: UILabel = {
        let lbl = UILabel()
        lbl.text = "시간을 설정해주세요."
        
        return lbl
    }()
    
    let dayText: UILabel = {
        let lbl = UILabel()
        lbl.text = "날짜를 선택해주세요."
        
        return lbl
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
        addSubview(alarmImageView)
        alarmImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(12)
            make.width.height.equalTo(40)
        }
        
        addSubview(timeText)
        timeText.snp.makeConstraints { make in
            make.top.equalTo(alarmImageView.snp.top)
            make.leading.equalTo(alarmImageView.snp.trailing).offset(12)
        }
        
        addSubview(dayText)
        dayText.snp.makeConstraints { make in
            make.leading.equalTo(alarmImageView.snp.trailing).offset(12)
            make.bottom.equalTo(alarmImageView.snp.bottom)
        }
    }
}
