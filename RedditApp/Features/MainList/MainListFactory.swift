//
//  MainListFactory.swift
//  RedditApp
//
//  Created by Râmede on 15/08/21.
//

struct MainListFactory {
    static func make() -> MainListViewController {
        let presenter = MainListPresenter()
        let interactor = MainListInteractor(presenter: presenter)
        let viewController = MainListViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}
