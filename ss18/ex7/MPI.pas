program MPI;
uses MP_Lex, MPI_Syn;

var inFileName: string;

begin
    if paramCount <> 1 then begin
        writeLN('Usage: MPI <input.mp>');
        halt;
    end;
    initLex(paramStr(1));

    S;
    writeLn('Success: ', success);
end.
