//
//  CheckListViewController.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import RxViewController

class CheckListViewController: UIViewController {
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
        view.backgroundColor = .white
        setupLayout()
        bind()
    }
    
    private func bind() {
        let input = CheckListViewModel.Input(
            tapTimeView: timeView.rx.tapGesture().when(.recognized).map { _ in () }
        )
        
        let output = viewModel.transform(input: input)
        
        // 시간 설정 화면 띄우기
        output.showSetTimeView
            .subscribe(onNext: { [weak self] in
                self?.presentEditDateViewController()
            }).disposed(by: disposeBag)
    }
    
    private func presentEditDateViewController() {
        let vc = EditDateViewController(viewModel: EditDateViewModel())
        self.present(vc, animated: true)
    }
    
    // MARK: - View
    private let timeView: TimeView = {
        let view = TimeView()
        view.backgroundColor = .white
        view.setRadiusAndShadow()
        
        return view
    }()
    
    // MARK: - Layout
    private func setupLayout() {
        view.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(80)
        }
    }
}
