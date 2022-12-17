//
//  EditDateViewModel.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/17.
//

import Foundation
import RxSwift
import RxCocoa

class EditDateViewModel: ViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    let tableViewItems: BehaviorRelay<[Day]> = BehaviorRelay(value: [
        Day(title: "일", isSelected: false),
        Day(title: "월", isSelected: false),
        Day(title: "화", isSelected: false),
        Day(title: "수", isSelected: false),
        Day(title: "목", isSelected: false),
        Day(title: "금", isSelected: false),
        Day(title: "토", isSelected: false)
    ])
    
    struct Input {
        let tapSaveButton: Observable<Void>
        let changeDate: Observable<Date>
        let changeDay: Observable<Int>
    }
    
    struct Output {
        let save: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let tapSaveButton = input.tapSaveButton.map { _ in
            // TODO: - 저장되면 return true
            return false
        }
        
        input.changeDate
            .map { date in
                let dateFomatter = DateFormatter()
                dateFomatter.timeZone = .autoupdatingCurrent
                dateFomatter.locale = Locale(identifier: "ko_KR")
                dateFomatter.dateFormat = "HH:mm:ss"
                
                return dateFomatter.string(from: date)
            }
            .subscribe(onNext: { date in
                print(date)
            })
            .disposed(by: disposeBag)
        
        input.changeDay
            .subscribe(onNext: { [weak self] index in
                var items = self?.tableViewItems.value
                items![index].isSelected.toggle()
                self?.tableViewItems.accept(items!)
            })
            .disposed(by: disposeBag)
            
        
        return Output(save: tapSaveButton)
    }
}
