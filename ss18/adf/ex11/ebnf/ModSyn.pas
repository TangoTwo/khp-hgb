unit ModSyn;

interface
var
    success : boolean;
procedure S;

implementation
uses ModLex;

procedure cartoon; forward;
procedure statement; forward;
procedure shapeDef; forward;
procedure action; forward;

procedure S;
var e : integer;
begin
    (* S = expr EOF. *)
    success := TRUE;
    cartoon; if not success then exit;
    if curSy <> eofSy then begin success := FALSE; exit; end;
    newSy;
    (* sem *)
    //write(e);
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
        newSy;
        if curSy <> equalSy then begin success := FALSE; exit; end;
        newSy;
        shapeDef; if not success then exit;
    end else if(curSy = showSy) or (curSy = hideSy) then begin
        newSy;
        if curSy <> identSy then begin success := FALSE; exit; end;
        writeLn(identStr);
        newSy;
    end else begin
        action; if not success then exit;
    end;
end;

procedure shapeDef;
var num1, num2, num3, num4 : integer;
    ident : string;
begin
    case curSy of
        lineSy : begin 
                newSy; 
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num1 := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num2 := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num3 := numVal;(*ENDSEM*)      
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num4 := numVal;(*ENDSEM*)
                newSy;
            end;
        rectangleSy : begin 
                newSy; 
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num1 := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num2 := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num3 := numVal;(*ENDSEM*)      
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num4 := numVal;(*ENDSEM*)
                newSy;
            end;
        circleSy : begin 
                newSy; 
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num1 := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num2 := numVal;(*ENDSEM*)
                newSy;
                if curSy <> numberSy then begin success := FALSE; exit; end;
                (*SEM*)num3 := numVal;(*ENDSEM*)      
                newSy;
            end;
        pictureSy : begin 
                newSy; 
                if curSy <> identSy then begin success := FALSE; exit; end;
                (*SEM*)ident := identStr; (*ENDSEM*)
                newSy;
                while (curSy = plusSy)do begin
                    newSy;
                    if curSy <> identSy then begin success := FALSE; exit; end;
                    (*SEM*)ident := identStr; (*ENDSEM*)
                    newSy;
                end; (* while *)
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
end;

begin
end.
