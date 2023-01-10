struct CommitSourceFile: Identifiable, Hashable, Equatable {
    
    var id: SourceCodeID
    
    var filename: SourceFilename
    
    var text: SourceText
    
}
