//
//  PhotosUploaderViewController.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

class PhotosUploaderViewController: CreationFlowViewController {
    
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    let cameraAction = "Camera"
    let libraryAction = "Gallery"
    let cancelAction = "Cancel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFirstController = true
        viewModel = CreatorViewModel()
        setupView()
        setupNavigation()
    }
    
    //MARK: Setup View
    
    func setupView() {
        let mainView = PhotosUploaderView(frame: view.frame)
        mainView.uploadPhotoButton.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        view = mainView
    }
    
    //MARK: Navigation
    
    func setupNavigation() {
        imagePickerController.delegate = self
        setRightBarButtonText(to: "Skip")
        setLeftBarButtonToCancel()
    }
    
    @objc private func selectPhoto(_ sender: UIButton) {
        showActionSheet()
    }
    
    private func showActionSheet() {
        let actionSheet = getActionSheet()
        present(actionSheet, animated: true)
    }
}

//MARK: Image Picker

extension PhotosUploaderViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        viewModel.updatePicture(selectedImage)
        setRightBarButtonText(to: "Next")
        (view as? PhotosUploaderView)?.selectedPhotoView.image = selectedImage
        (view as? PhotosUploaderView)?.uploadPhotoButton.setTitle("Change Photo", for: .normal)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func getActionSheet() -> UIAlertController{
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addAction(UIAlertAction(title: cameraAction, style: UIAlertAction.Style.default) { _ in
            self.showImagePicker(source: .camera)
        })
        actionSheet.addAction(UIAlertAction(title: libraryAction, style: UIAlertAction.Style.default) { _ in
            self.showImagePicker(source: .photoLibrary)
        })
        actionSheet.addAction(UIAlertAction(title: cancelAction, style: UIAlertAction.Style.cancel))
        return actionSheet
    }
    
    fileprivate func showImagePicker(source: UIImagePickerController.SourceType) {
        imagePickerController.sourceType = source
        present(imagePickerController, animated: true)
    }
}

class RentalPhotosUploaderViewController: PhotosUploaderViewController {
    override var nextVC: CreationFlowViewController {
        return RentalCategorySelectorViewController()
    }
    override var navigationTitle: String {
        return "Lend Something"
    }
}

class RequestPhotosUploaderViewController: PhotosUploaderViewController {
    override var nextVC: CreationFlowViewController {
        return RequestCategorySelectorViewController()
    }
    override var navigationTitle: String {
        return "Borrow Something"
    }
}
