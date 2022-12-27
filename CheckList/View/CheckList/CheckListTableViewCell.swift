//
//  CheckListTableViewCell.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/17.
//

import UIKit
import RxSwift

class CheckListTableViewCell: UITableViewCell {
    static let identifier = "CheckListTableViewCell"
    
    var disposeBag = DisposeBag()
    let tapCheckBox = PublishSubject<Bool>()

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
    
    func configure(item: CheckListItem) {
        self.selectionStyle = .none
        
        self.boxButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.tapCheckBox.onNext(!item.isDone)
            })
            .disposed(by: disposeBag)
        
        if item.isDone {
            self.titleLabel.attributedText = item.title.strikeThrough()
            self.titleLabel.textColor = .gray
            self.boxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            self.boxButton.tintColor = .gray
        } else {
            self.titleLabel.attributedText = .init(string: item.title)
            self.titleLabel.textColor = .black
            self.boxButton.setImage(UIImage(systemName: "square"), for: .normal)
            self.boxButton.tintColor = .black
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
    
    let boxButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "square"), for: .normal)
        btn.tintColor = .black
        
        return btn
    }()
    
    // MARK: - Layout
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(1)
            make.trailing.equalToSuperview().offset(-1)
        }
        
        containerView.addSubview(boxButton)
        boxButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(containerView)
            make.width.height.equalTo(containerView.snp.height)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(12)
        }
    }
}
