//
//  PostsViewModel.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Combine

@MainActor
class PostsViewModel {
    var cancelBag = Set<AnyCancellable>()
    let useCase: PostUseCase
    let input = Input()
    let output = Output()
    
    class Input {
        let viewDidLoad = PassthroughSubject<Void, Never>()
        let savePost = PassthroughSubject<PostDTO, Never>()
    }
    
    class Output {
        let showLoader = PassthroughSubject<Bool, Never>()
        let showMessage = PassthroughSubject<String, Never>()
        let updatePosts = PassthroughSubject<[PostDTO], Never>()
    }
    
    init(useCase: PostUseCase) {
        self.useCase = useCase
        bind()
    }
    
    private func bind() {
        input.viewDidLoad.sink { [weak self] _ in
            guard let self = self else { return }
            self.output.showLoader.send(true)
            Task {
                let response = await self.useCase.fetchPosts(parameters: FetchPostsRequest())
                self.output.showLoader.send(false)
                switch response {
                case .success(let posts):
                    self.output.updatePosts.send(posts)
                case .failure(let apiError):
                    self.output.showMessage.send(apiError.customDescription)
                }
            }
        }.store(in: &cancelBag)
        
        input.savePost.sink { [weak self] post in
            guard let self = self else { return }
            self.output.showLoader.send(true)
            self.useCase.savePost(post: FavoritePostModel(with: post)) { result in
                self.output.showLoader.send(false)
                switch result {
                case .success(_):
                    self.output.showMessage.send(.Localized.savedPostConfirmation)
                case let .failure(error):
                    self.output.showMessage.send(error.localizedDescription)
                }
            }
        }.store(in: &cancelBag)
    }
}
