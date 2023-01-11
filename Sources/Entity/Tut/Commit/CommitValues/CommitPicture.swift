public struct CommitPicture: Identifiable, Hashable, Equatable {
    
    public var id: PictureID
    
    public var binary: PictureData
    
    public var filename: PictureFilename
    
    public var `extension`: PictureFileExtension
    
    public init(id: PictureID, binary: PictureData, filename: PictureFilename, extension: PictureFileExtension) {
        self.id = id
        self.binary = binary
        self.filename = filename
        self.`extension` = `extension`
    }
    
}
