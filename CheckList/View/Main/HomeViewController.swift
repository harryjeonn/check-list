//
//  HomeViewController.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import RxViewController

class HomeViewController: UIViewController {
    let viewModel: CheckListViewModel
    var disposeBag = DisposeBag()
    
    init(viewModel: CheckListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = CheckListViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    private func bind() {
        topBarView.rightButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.presentEditDateViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func presentEditDateViewController() {
        let vc = CheckListViewController(viewModel: CheckListViewModel())
        self.present(vc, animated: true)
    }

    // MARK: - View
    let topBarView: TopBarView = {
        let view = TopBarView()
        view.titleLabel.text = "홈"
        view.leftButton.setTitle("설정", for: .normal)
        view.rightButton.setTitle("추가", for: .normal)
        
        return view
    }()
    
    private func setupLayout() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(topBarView)
        topBarView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(0)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
    }
}
