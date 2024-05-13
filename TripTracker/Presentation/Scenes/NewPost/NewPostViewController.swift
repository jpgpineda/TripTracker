//
//  NewPostViewController.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit
import Combine

class NewPostViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var selectPictureView: UIView!
    @IBOutlet weak var pictureView: UIView!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addPostButton: UIButton!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    let imagePicker = UIImagePickerController()
    private let configurator = NewPostConfiguratorImplementation()
    private var viewModel: NewPostViewModel?
    private var cancelBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = configurator.configure()
        setupView()
    }
    
    private func setupView() {
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.modalTransitionStyle = .coverVertical
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        descriptionTextView.delegate = self
        view.hideKeyboardWhenTappedAround()
        bind()
    }
    
    private func bind() {
        viewModel?.outPut.showLoader.sink(receiveValue: { [weak self] isShowing in
            if isShowing {
                self?.showLoader()
            } else {
                self?.dismissLoader()
            }
        }).store(in: &cancelBag)
        
        viewModel?.outPut.showMessage.sink(receiveValue: { [weak self] message in
            self?.showMessage(message: message)
        }).store(in: &cancelBag)
        
        viewModel?.outPut.dismissView.sink(receiveValue: { [weak self] _ in
            self?.showConfimation(title: .Localized.atenttion,
                                  message: .Localized.newPostConfirmation,
                                  cancel: nil,
                                  confirm: .Localized.confirm,
                                  confirmAction: {
                self?.dismiss(animated: true)
            })
        }).store(in: &cancelBag)
    }
    
    @IBAction func selectPicture(_ sender: UIButton) {
        showGallery()
    }
    
    private func showGallery() {
        let alert = UIAlertController(title: .Localized.selectPicture,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: .Localized.gallery,
                                      style: .default, handler: { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }))
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: .Localized.camera,
                                          style: .default, handler: { _ in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true)
            }))
        }
        
        alert.addAction(UIAlertAction(title: .Localized.cancel,
                                      style: .destructive))
        present(alert, animated: true)
    }
    
    @IBAction func addNewPost(_ sender: UIButton) {
        viewModel?.input.createNewPost.send()
    }
    
    private func validateFields() {
        guard let viewModel = viewModel else { return }
        addPostButton.isEnabled = viewModel.validateFields()
        addPostButton.backgroundColor = viewModel.validateFields() ? .link : .secundaryText
    }
}

extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        pictureView.isHidden = false
        descriptionView.isHidden = false
        pictureImage.image = image.resized(to: CGSize(width: pictureView.bounds.width, height: pictureImage.bounds.height))
        viewModel?.input.updateImage.send(image.encodeToBase64())
        validateFields()
        picker.dismiss(animated: true)
    }
}

extension NewPostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .secundaryText {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = .Localized.postDescriptionHint
            textView.textColor = .secundaryText
            viewModel?.input.updateDescription.send(.empty)
            validateFields()
        } else {
            viewModel?.input.updateDescription.send(textView.text)
            validateFields()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
