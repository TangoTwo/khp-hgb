program listOOP;

type
    listNode = ^listPtr;
    listPtr = record
              val  : integer;
              next : listNode;
          end;
    list = ^listObj;
    listObj = OBJECT
        private
        startList : listNode;
        sizeList : integer;
        public
            constructor init;
            procedure add(val : integer); virtual;
            function contains(val : integer) : boolean; virtual;
            function size : integer;
            procedure remove(val : integer); virtual;
            procedure clear;
            procedure printList;
        private
            procedure removeNextNode(var node : listNode);
    end;
    sortedList = ^sortedListObj;
    sortedListObj = object(listObj)
        public
            procedure add(val : integer); virtual;
            function contains(val : integer) : boolean; virtual;
            procedure remove(val : integer); virtual;
end;

constructor listObj.init;
begin
    startList := NIL;
    sizeList := 0;
end;

procedure listObj.add(val : integer);
var nextList : listNode;
    buffList : listNode;
begin
    new(nextList);
    nextList^.val := val;
    if(size = 0) then
        startList := nextList
    else begin
        buffList := startList;
        while(buffList <> NIL) and (buffList^.next <> NIL) do
            buffList := buffList^.next;
        buffList^.next := nextList;
    end;
    inc(sizeList);
end;

function listObj.contains(val : integer) : boolean;
var curList : listNode;
    finished : boolean;
begin
    contains := FALSE;
    finished := FALSE;
    curList := startList;
    while(NOT finished) do begin
        if(curList^.val = val) then begin
            contains := TRUE;
            finished := TRUE;
        end else begin
            if(curList^.next = NIL) then begin
                finished := TRUE;
            end else begin
                curList := curList^.next;
            end;
        end;
    end;
end;

function listObj.size : integer;
var tSize : integer;
    buffList : listNode;
begin
    buffList := startList;
    tSize := 0;
    while(buffList <> NIL) do begin
        inc(tSize);
        buffList := buffList^.next;
    end;
    size := tSize;
end;

procedure listObj.remove(val : integer);
var buffList : listNode;
begin
    if(size = 0) then begin
        writeLn('Cannot remove from empty list');
        exit;
    end;
    buffList := startList;
    while(buffList^.next <> NIL) do begin
        if(buffList^.next^.val = val) then begin
            removeNextNode(buffList);
        end else
            buffList := buffList^.next;
    end;
    if(startList^.val = val) then begin
        buffList := startList^.next;
        dispose(startList);
        dec(sizeList);
        startList := buffList;
    end;
end;

procedure listObj.clear;
var buffList : listNode;
begin
    buffList := startList;
    while(buffList^.next <> NIL) do begin
        removeNextNode(buffList);
    end;
    dispose(startList);
    sizeList := 0;
    startList := NIL;
end;

procedure listObj.removeNextNode(var node : listNode);
var buffList : listNode;
begin
    buffList := node^.next^.next;
    dispose(node^.next);
    node^.next := buffList;
    dec(sizeList);
end;

procedure listObj.printList;
var buffList : listNode;
begin
    buffList := startList;
    while(buffList <> NIL) do begin
        writeLn(buffList^.val);
        buffList := buffList^.next;
    end;
end;

procedure sortedListObj.add(val : integer);
var nextList : listNode;
    buffList : listNode;
    finished : boolean;
begin
    finished := FALSE;
    new(nextList);
    nextList^.val := val;
    if(size = 0) then
        startList := nextList
    else if startList^.val >= nextList^.val then begin
        nextList^.next := startList;
        startList := nextList;
    end else begin
        buffList := startList;
        while(buffList <> NIL) and (buffList^.next <> NIL) and (NOT finished) do begin
            if(buffList^.next^.val >= val) then begin
                nextList^.next := buffList^.next;
                finished := TRUE;
            end else
                buffList := buffList^.next;
        end;
            buffList^.next := nextList;
    end;
    inc(sizeList);
end;

function sortedListObj.contains(val : integer) : boolean;
var curList : listNode;
    finished : boolean;
begin
    contains := FALSE;
    finished := FALSE;
    curList := startList;
    while(NOT finished) do begin
        if(curList^.val = val) then begin
            contains := TRUE;
            finished := TRUE;
        end else begin
            if(curList^.next = NIL) or (curList^.val < val) then begin
                finished := TRUE;
            end else begin
                curList := curList^.next;
            end;
        end;
    end;
end;

procedure sortedListObj.remove(val : integer);
var buffList : listNode;
    finished : boolean;
begin
    finished := FALSE;
    if(size = 0) then begin
        writeLn('Cannot remove from empty list');
        exit;
    end;
    buffList := startList;
    while(buffList^.next <> NIL) and (NOT finished) do begin
        if(buffList^.next^.val = val) then begin
            removeNextNode(buffList);
        end else
            buffList := buffList^.next;
        if(buffList^.val > val) then
            finished := TRUE;
    end;
    if(startList^.val = val) then begin
        buffList := startList^.next;
        dispose(startList);
        dec(sizeList);
        startList := buffList;
    end;
end;

var tList : sortedList;
    i : integer;
begin
    new(tList, init);
    tList^.add(3);
    tList^.add(3);
    tList^.add(3);
    tList^.add(2);
    tList^.add(2);
    tList^.add(2);
    tList^.add(3);
    writeLn('Size: ', tList^.size);
    tList^.printList;
    tList^.remove(3);
    writeLn('Size: ', tList^.size);
    tList^.clear;
end.

