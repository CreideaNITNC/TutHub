public struct Commit: Identifiable, Hashable, Equatable {
    
    public var id: CommitID
    
    public var message: CommitMessage
    
    public var codes: [CommitSourceFile]
    
    public var pictures: [CommitPicture]
    
    public init(id: CommitID, message: CommitMessage, codes: [CommitSourceFile], pictures: [CommitPicture]) {
        self.id = id
        self.message = message
        self.codes = codes
        self.pictures = pictures
    }
    
}
