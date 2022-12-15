//
//  MainViewModel.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/15.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel: ViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let tapTestButton: Observable<Void>
    }
    
    struct Output {
        let testTitle: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let testTitle = input.tapTestButton
            .map { "\(Int.random(in: 0...10))" }
        
        return Output(testTitle: testTitle)
    }
}
