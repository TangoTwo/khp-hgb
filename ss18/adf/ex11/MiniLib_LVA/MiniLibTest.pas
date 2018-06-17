program MiniLibTest;
uses MLObj, MetaInfo, MLInt, MLVect, MLColl;

var
    int : MLInteger;
    v : MLVector;
    it : MLIterator;
    obj : MLObject;

begin
    new(int, init(314));
    writeLn(int^.class);
    writeLn(int^.baseClass);
    writeLn(int^.isA('MLObject'));
    writeLn(int^.asString);
    writeLn(int^.isEqualTo(int));
    writeLn(int^.isLessThan(int));

    v := newMLVector;
    v^.add(int);
    v^.add(newInteger(123));
    v^.add(newInteger(17));

    v^.sort;
    it := v^.newIterator;
    obj := it^.next;
    while obj <> NIL do begin
        obj^.writeAsString;
        obj := it^.next;
    end;
    dispose(it, done);
    v^.writeAsString;
    v^.disposeElements;
    dispose(v, done);
    
    writeMetaInfo;
end.
