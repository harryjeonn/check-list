//
//  MainViewController.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let viewModel: MainViewModel
    var disposeBag = DisposeBag()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = MainViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bind()
    }
    
    private func bind() {
        testButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.changeTitle()
            })
            .disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: timeView.testLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func presentSetTime() {
        
    }
    
    // MARK: - View
    private let timeView = TimeView()
    private let testButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Test", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        return btn
    }()
    
    // MARK: - Layout
    private func setupLayout() {
        view.addSubview(timeView)
        timeView.backgroundColor = .red
        timeView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(80)
        }
        
        view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
