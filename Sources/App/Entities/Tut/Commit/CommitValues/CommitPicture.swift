struct CommitPicture: Identifiable, Hashable, Equatable {
    
    var id: PictureID
    
    var binary: PictureData
    
    var filename: PictureFilename
    
    var `extension`: PictureFileExtension
    
}
