struct Commit: Identifiable, Hashable, Equatable {
    var id: CommitID
    
    var message: CommitMessage
    
    var codes: [CommitSourceFile]
    
    var pictures: [CommitPicture]
    
}
