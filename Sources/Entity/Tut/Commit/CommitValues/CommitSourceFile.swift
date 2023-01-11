public struct CommitSourceFile: Identifiable, Hashable, Equatable {
    
    public var id: SourceCodeID
    
    public var filename: SourceFilename
    
    public var text: SourceText
    
    public init(id: SourceCodeID, filename: SourceFilename, text: SourceText) {
        self.id = id
        self.filename = filename
        self.text = text
    }
    
}
