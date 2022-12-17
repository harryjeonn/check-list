//
//  CheckListTableViewCell.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/17.
//

import UIKit

class CheckListTableViewCell: UITableViewCell {
    static let identifier = "CheckListTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
//            make.leading.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(1)
            make.trailing.equalToSuperview().offset(-1)
        }
        
        containerView.addSubview(boxImageView)
        boxImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(containerView).offset(12)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(boxImageView.snp.trailing).offset(12)
        }
    }
    
    // MARK: - View
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setRadiusAndShadow()
        
        return view
    }()

    let titleLabel: UILabel = {
       let lbl = UILabel()
        
        return lbl
    }()
    
    let boxImageView: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(systemName: "square")
        img.tintColor = .black
        
        return img
    }()
}
