//
//  HomePresenter.swift
//  CeibaTest
//
//  Created by Juan Andres Vasquez Ferrer on 16-09-21.
//

import Foundation

protocol HomePresenterProtocol {
    func viewDidload()
    func bindView(_ view: HomeViewProtocol)
    func goToDetail(title: String)
}


class HomePresenter: HomePresenterProtocol {
   
    weak var view: HomeViewProtocol?
    let repository: HomeRepositoryProtocol
    let coordinator: BaseCoordinator
    
    init(repository: HomeRepositoryProtocol, coordinator: BaseCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }

    func viewDidload() {
        self.getData()
    }
    
    func bindView(_ view: HomeViewProtocol) {
        self.view = view
    }
    
    func goToDetail(title: String) {
        self.coordinator.navigate(.detail(title))
    }
    
    private func getData() {
        self.view?.showLoading()
        repository.getFeedHome { (response) in
            self.view?.stopLoading()
            switch response {
            case .success(let data):
                self.view?.renderTitles(data)
            case .failure(let error):
                self.view?.showError(error)
            }
        }
    }
}
