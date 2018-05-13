unit ParseGen_Syn;

interface
var
    success : boolean;

procedure parseArg; (* entry for recursive descent parser *)

implementation
uses ParseGen_Lex, FileWriter;

procedure writeSyIsNot;
begin
    writeToFile('FUNCTION SyIsNot(expectedSy: Symbol): BOOLEAN;',0);
    writeToFile('BEGIN',1);
    writeToFile('success := success AND (sy = expectedSy);',0);
    writeToFile('SyIsNot := NOT success;',0);
    writeToFile('END; (*SyIsNot*)',-1);
    writeToFile('',0);
end;

procedure writeSINTE(insert : string); (* SINTE = SyIsNot then exit *)
var tempString : string;
begin
    tempString := 'IF SyIsNot(' + insert + ') THEN EXIT;';
    writeToFile(tempString, 0);
    writeToFile('newSy;', 0);
end;

procedure writeINSTE(insert : string); (* INSTE = if not success then exit *)
var tempString : string;
begin
    tempString := insert + '; IF NOT success THEN Exit;';
    writeToFile(tempString, 0);
end;

procedure parseArg;
var tempSy : symbol;
    tempString : string;
    curProcedure : string;
begin
    success := TRUE;
    tempString := '';

    writeSyIsNot;
    
    while(sy <> eofSy) do begin
        newSy;
        if(sy = noSy) then begin
            success := FALSE;
            exit;
        end
        else if(sy = nonTermSy) then begin
            tempSy := sy;
            newSy;
            if(sy = isSy) then begin
                curProcedure := stringVal;
                tempString := 'PROCEDURE ' + stringVal + ';';
                writeToFile(tempString, 0);
                tempString := 'BEGIN';
                writeToFile(tempString, 1);
            end
            else begin
                writeINSTE(stringVal);
            end;
        end;
        if(sy = leftCurlSy) then begin
            writeToFile('WHILE sy = ... DO BEGIN', 1);
        end 
        else if(sy = rightCurlSy) then begin
            writeToFile('END; (*WHILE*)', -1);
        end
        else if(sy = arrowLeftSy) then begin
            writeToFile('IF sy = ... THEN BEGIN', 1);
        end
        else if(sy = arrowRightSy) then begin
            writeToFile('END (*IF*)', -1);
            writeToFile('ELSE', 1);
            writeToFile('success := FALSE;', -1);
        end
        else if(sy = orSy) then begin
            writeToFile('END (*IF*)', -1);
            writeToFile('ELSE IF sy = ... THEN BEGIN', 1);
        end
        else if(sy = identSy) then begin
            writeSINTE('identSy');
        end
        else if(sy = equalSy) then begin
            writeSINTE('equalSy');
        end
        else if(sy = barSy) then begin
            writeSINTE('barSy');
        end
        else if(sy = plusSy) then begin
            writeSINTE('plusSy');
        end
        else if(sy = mulSy) then begin
            writeSINTE('mulSy');
        end
        else if(sy = divSy) then begin
            writeSINTE('divSy');
        end
        else if(sy = minusSy) then begin
            writeSINTE('minusSy');
        end
        else if(sy = ltSy) then begin
            writeSINTE('ltSy');
        end
        else if(sy = gtSy) then begin
            writeSINTE('gtSy');
        end
        else if(sy = leftParSy) then begin
            writeSINTE('leftParSy');
        end
        else if(sy = rightParSy) then begin
            writeSINTE('rightParSy');
        end
        else if(sy = leftOptSy) then begin
            writeSINTE('leftOptSy');
        end
        else if(sy = rightOptSy) then begin
            writeSINTE('rightOptSy');
        end
        else if(sy = leftIterSy) then begin
            writeSINTE('leftIterSy');
        end
        else if(sy = rightIterSy) then begin
            writeSINTE('rightIterSy');
        end
        else if(sy = numberSy) then begin
            writeSINTE('numberSy');
        end
        else if(sy = dotSy) then begin
            tempString := 'END; (*' + curProcedure + '*)';
            writeToFile(tempString, -1);
            writeToFile('',0);
        end;
    end;
end;

begin
end.
