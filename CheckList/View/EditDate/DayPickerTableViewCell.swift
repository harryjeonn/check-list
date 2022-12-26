//
//  DayPickerTableViewCell.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/17.
//

import UIKit
import SnapKit

class DayPickerTableViewCell: UITableViewCell {
    static let identifier = "DayPickerTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ item: Day) {
        self.titleLabel.text = item.title
        self.checkImage.isHidden = !item.isSelected
    }
    
    // MARK: - View
    let titleLabel: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    
    let checkImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "checkmark")
        img.tintColor = .black
        
        return img
    }()
    
    // MARK: - Layout
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(12)
        }
        
        contentView.addSubview(checkImage)
        checkImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-12)
            make.width.height.equalTo(24)
        }
    }
}
