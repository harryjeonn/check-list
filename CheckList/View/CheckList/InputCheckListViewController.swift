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
    let viewModel = InputCheckListViewModel()
    
    var currentText = ""
    var addCheckList = PublishSubject<String>()
    var editCheckList = PublishSubject<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureTextField()
        bind()
    }
    
    private func bind() {
        let input = InputCheckListViewModel.Input(
            tapEnterButton: enterButton.rx.tap.map { _ in () },
            changeTextField: textField.rx.text.orEmpty.map { $0 }
            )
        
        let output = viewModel.transform(input: input)
        
        output.checkList
            .distinctUntilChanged()
            .filter { [weak self] _ in self?.currentText == "" }
            .subscribe(onNext: { [weak self] checkList in
                self?.addCheckList.onNext(checkList)
                self?.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        output.checkList
            .distinctUntilChanged()
            .filter { [weak self] _ in self?.currentText != "" }
            .subscribe(onNext: { [weak self] checkList in
                self?.editCheckList.onNext(checkList)
                self?.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        backgroundView.rx.tapGesture()
            .when(.recognized)
            .map { _ in () }
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTextField() {
        textField.text = currentText
        textField.placeholder = currentText == "" ? "항목을 입력해주세요" : currentText
        textField.becomeFirstResponder()
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
        
        return textField
    }()
    
    let enterButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "paperplane"), for: .normal)
        btn.tintColor = .black
        
        return btn
    }()
    
    // MARK: - Layout
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
}
