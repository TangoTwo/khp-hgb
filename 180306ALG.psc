const m = ...
type HashTable = array[0:m-1] of NodePtr
var table: HashTable -- Gedächtnisvariable

InitHashTable()
    var i : int
begin
    for (i:=0 to m-1) do table[i]:= null end
end InitHashTable

NewNode(key:string) : NodePtr
    var n: NodePtr
begin
    n:= New(NodePtr)
    n -> key:= key
    n -> next:=null
    return(n)
end NewNode
