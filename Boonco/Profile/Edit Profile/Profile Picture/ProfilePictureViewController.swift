//
//  ProfilePictureViewController.swift
//  Lender
//
//  Created by Peter Huang on 2020-04-10.
//  Copyright © 2020 Project PJ. All rights reserved.
//

//TODO: Add functionality to crop and filter profile picture (v2, not in MVP)

import UIKit

class ProfilePictureViewController: UIViewController, ProfileEditorModelDelegate {
    
    //MARK: Constants and variables
    
    let imagePickerController = UIImagePickerController()
    var profilePictureView = ProfilePictureView()
    var viewModel: ProfileEditorViewModel!
    
    //TODO: After text field updators work, add the picture update functionality
    
    //var viewModel = ProfileViewModel()
    
    let navigationTitle: String = "Upload Profile Picture"
    
    //MARK: Activity life cycle
    
    override func loadView() {
        view = profilePictureView
        viewModel = ProfileEditorViewModel(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupLeftBarButton()
        imagePickerController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        setupLeftBarButton()
        super.viewDidDisappear(animated)
    }
    
    //MARK: Delegate function
    
    func didUpdateProfileData() {
        //Update view if we choose to implement a profile picture check option in the edit subview
    }
    
    //MARK: Navigation bar buttons
    
    func setupLeftBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(didTapGoBack))
    }
    
    func setupDoneBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    //MARK: Set up the controller's actions
    
    private func setupActions() {
        tapUploadPictureButton()
    }
    
    private func tapUploadPictureButton() {
        profilePictureView.uploadPhotoButton.addTarget(self, action: #selector(selectPicture), for: .touchUpInside)
    }
    
    //MARK: IBAction Events
    
    @objc private func didTapGoBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapDone(_ sender: UIBarButtonItem) {
        viewModel.postProfilePicture()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func selectPicture(_ sender: UIButton) {
        showActionSheet()
    }
    
    private func showActionSheet() {
        let actionSheet = getActionSheet()
        present(actionSheet, animated: true)
    }
}

//MARK: Image Picker & Delegates

extension ProfilePictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        viewModel.updateCurrentPicture(selectedImage)
        setupDoneBarButton()
        
        profilePictureView.selectedPicture.image = selectedImage
        profilePictureView.uploadPhotoButton.setTitle("Change profile picture", for: .normal)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func getActionSheet() -> UIAlertController{
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { _ in
            self.showImagePicker(source: .camera)
        })
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default) { _ in
            self.showImagePicker(source: .photoLibrary)
        })
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        return actionSheet
    }
    
    private func showImagePicker(source: UIImagePickerController.SourceType) {
        imagePickerController.sourceType = source
        present(imagePickerController, animated: true)
    }
}
