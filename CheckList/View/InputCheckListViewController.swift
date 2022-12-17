//
//  InputCheckListViewController.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/18.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class InputCheckListViewController: UIViewController {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
    }
    
    private func bind() {
        backgroundView.rx.tapGesture()
            .when(.recognized)
            .map { _ in () }
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        enterButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(70)
        }
        
        containerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(12)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(enterButton)
        enterButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-12)
        }
    }
    
    // MARK: - View
    let backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        
        return view
    }()
    
    let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.setRadiusAndShadow()
        
        return view
    }()
    
    let textField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "항목을 입력해주세요."
        
        return textField
    }()
    
    let enterButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "paperplane"), for: .normal)
        btn.tintColor = .black
        
        return btn
    }()
}
