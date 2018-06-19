unit ModSyn;

interface
uses Windows, Crt, WinGraph;
var
    success : boolean;
procedure S(tDc: HDC; tWnd: HWnd; tRe: TRect);

implementation
uses ModLex, ModShapes;

procedure cartoon; forward;
procedure statement; forward;
procedure shapeDef; forward;
procedure action; forward;
var pic : picture;
    tName : string;
    dc : HDC;
wnd : HWnd;
re : TRect;
    
procedure S(tDc: HDC; tWnd: HWnd; tRe: TRect);
begin
    (* S = expr EOF. *)
    dc := tDc;
    wnd := tWnd;
    re := tRe;
    success := TRUE;
    new(pic, init('origin'));
    cartoon; if not success then exit;
    if curSy <> eofSy then begin success := FALSE; exit; end;
    newSy;
    (* sem *)
    pic^.write;
writeln('Wrote stuff');
    (* endsem *)
end;

procedure cartoon;
begin
    (* Statement [ ';' Statement }. *)
    statement; if not success then exit;
    while (curSy = semicolonSy)do begin
        newSy;
        statement; if not success then exit;
    end; (* while *)
end;

procedure statement;
begin
    (* ident '=' ShapeDef | ('SHOW' | 'HIDE') ident | Action. *)
    if(curSy = identSy) then begin
        tName := identStr;
        newSy;
        if curSy <> equalSy then begin success := FALSE; exit; end;
        newSy;
        shapeDef; if not success then exit;
    end else if(curSy = showSy) or (curSy = hideSy) then begin
        case curSy of
            showSy : begin
                    newSy;
                    if curSy <> identSy then begin success := FALSE; exit; end;
                    (*SEM*)
                    if pic^.contains(identStr) <> NIL then
                        pic^.contains(identStr)^.setVisible(TRUE)
                    else
                        writeLn(identStr, ' not declared!');
                    (*ENDSEM*)
                end;
            hideSy : begin
                    newSy;
                    if curSy <> identSy then begin success := FALSE; exit; end;
                    (*SEM*)
                    if pic^.contains(identStr) <> NIL then
                        pic^.contains(identStr)^.setVisible(FALSE)
                    else
                        writeLn(identStr, ' not declared!');
                    (*ENDSEM*)
                end;
        end;
        newSy;
        pic^.draw(dc);
    end else begin
        action; if not success then exit;
    end;
end;

procedure shapeDef;
var p, q : pointRec;
    radius : integer;
    ident : string;
    l : line;
    c : circle;
    r : rectangle;
    userPic : picture;
begin
    case curSy of
        lineSy : begin 
                newSy; 
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)p.x := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)p.y := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)q.x := numVal;(*ENDSEM*)      
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)q.y := numVal;(*ENDSEM*)
                newSy;
                (*SEM*) 
                new(l, init(p, q, tName));
                pic^.add(l);
                (*ENDSEM*)
            end;
        rectangleSy : begin 
                newSy; 
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)p.x := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)p.y := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)q.x := numVal;(*ENDSEM*)      
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)q.y := numVal;(*ENDSEM*)
                newSy;
                (*SEM*) 
                new(r, init(p, q, tName));
                pic^.add(r);
                (*ENDSEM*)
            end;
        circleSy : begin 
                newSy; 
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)p.x := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)p.y := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)radius := numVal;(*ENDSEM*)      
                newSy;
                (*SEM*) 
                new(c, init(p, radius, tName));
                pic^.add(c);
                (*ENDSEM*)
            end;
        pictureSy : begin 
                (*SEM*) new(userPic, init(tName)); (*ENDSEM*)
                newSy;
                if curSy <> identSy then begin success := FALSE; exit; end;
                (*SEM*)
		//writeLn('Pointer:', integer(pic^.contains(identStr)));
                if pic^.contains(identStr) <> NIL then
                    userPic^.add(pic^.contains(identStr))
                else
                    writeLn(identStr, ' not declared!');
                (*ENDSEM*)
                newSy;
                while (curSy = plusSy)do begin
                    newSy;
                    if curSy <> identSy then begin success := FALSE; exit; end;
                    (*SEM*)
                    if pic^.contains(identStr) <> NIL then
                        userPic^.add(pic^.contains(identStr))
                    else
                        writeLn(identStr, ' not declared!');
                    (*ENDSEM*)
                    newSy;
                end; (* while *)
		pic^.add(userPic);
		pic^.draw(dc);
            end;
        else begin
            success := FALSE; exit;
        end; (* else *)
    end;(* case *)
end;

procedure action;
var ident : string;
    xMove, yMove : integer;
begin
    if curSy <> moveSy then begin success := FALSE; exit; end;
    newSy;
    if curSy <> identSy then begin success := FALSE; exit; end;
    (*SEM*)ident := identStr; (*ENDSEM*)
    newSy;
    if curSy <> numberSy then begin success := FALSE; exit; end;
    (*SEM*)xMove := numVal;(*ENDSEM*)
    newSy;
    if curSy <> numberSy then begin success := FALSE; exit; end;
    (*SEM*)yMove := numVal;(*ENDSEM*)
    newSy;
    (*SEM*)
    if pic^.contains(identStr) <> NIL then
        pic^.contains(identStr)^.move(xMove, yMove)
    else
        writeLn(identStr, ' not declared!');
    (*ENDSEM*)
    FillRect(dc, re, 0);
    pic^.draw(dc);
end;

begin
end.
