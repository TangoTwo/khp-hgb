program StoryGen;

type
    replacementPair = record
                          oldWord : string;
                          newWord : string;
                      end;
    replacementPairArray = array of replacementPair;

var
    replacementWords : replacementPairArray;

function fileExists(fromFileName : string) : boolean;
var
    f : TEXT;
begin
    (*$I-*) 
    assign(f, fromFileName);
    Reset(f); //Creates error
    if IOResult <> 0 then begin 
        fileExists := FALSE;
    end else
        fileExists := TRUE;
    (*$I+*)
end;

function isDelimiter(character : string) : boolean;
begin
    if(character = ' ') or (character = '.') or (character = '!') or (character = '?') then
        isDelimiter := TRUE
    else
        isDelimiter := FALSE;
end;

function isEqual(oldWord, newWord : string) : boolean;
var
    lengthOldWord : integer;
    lengthNewWord : integer;
begin
    lengthOldWord := length(oldWord);
    lengthNewWord := length(newWord);
    if(isDelimiter(oldWord[lengthOldWord])) then
        delete(oldWord,lengthOldWord,1);
    if oldWord = newWord then
        isEqual := TRUE
    else
        isEqual := FALSE;
end;

function getAndRemoveFirstWord(var line : string) : string;
var
    i : integer;
    finished : boolean;
    curWord : string;
begin
    i := 1;
    finished := FALSE;
    curWord := '';
    while (i <= length(line)) and (finished = FALSE) do begin
        if(isDelimiter(line[i])) or (i = length(line)) then begin
            if not(line[i] = ' ') then
                curWord := curWord + line[i];
            getAndRemoveFirstWord := curWord;
            Delete(line,1,i);
            finished := TRUE;
        end else begin
            curWord := curWord + line[i];
        end;
        inc(i);
    end;
end;
procedure splitLine(line : string; var lineWords : array of string);
var
    words : integer;
    finished : boolean;
begin
    words := 0;
    finished := FALSE;
    while (line <> '') and (finished = FALSE) do begin
        lineWords[words] := getAndRemoveFirstWord(line);
        if(words >= 2) then
            finished := TRUE;
        inc(words);
    end;
end;

procedure copyText(fromFileName, toFileName : string);
var
    inFile, outFile : TEXT;
    line : string;
begin
    assign(inFile, fromFileName);
    assign(outFile, toFileName);
    reset(inFile);
    rewrite(outFile); // overwrite if file exists
    while not eof(inFile) do begin
        readln(inFile, line);
        writeln(outFile, line);
    end;
    close(inFile);
    close(outFile);
end;

procedure parseRepls(fromFileName : string);
var
    inFile : TEXT;
    line : string;
    lineWords : array[0..1] of string;
    i : integer;
begin
    i := 0;
    assign(inFile, fromFileName);
    reset(inFile);
    while not eof(inFile) do begin
        setLength(replacementWords, length(replacementWords)+1);
        readln(inFile, line);
        splitLine(line, lineWords);
        replacementWords[i].oldWord := lineWords[0];
        replacementWords[i].newWord := lineWords[1];
        inc(i);
    end;
    close(inFile);
end;

function replaceWordsInLine(line : string) : string;
var
    curWord : string;
    i : integer;
    newLine : string;
    finished : boolean;
    endSymbol : string;
begin
    newLine := '';
    finished := FALSE;
    while (line <> '') do begin
        i := 0;
        endSymbol := '';
        finished := FALSE;
        curWord := getAndRemoveFirstWord(line);
        while(i < length(replacementWords)) and (finished = FALSE) do begin
            if(isDelimiter(curWord[length(curWord)])) then begin
                endSymbol := curWord[length(curWord)];
            end;
            if(isEqual(curWord,replacementWords[i].oldWord)) then begin
                curWord := replacementWords[i].newWord + endSymbol;
                finished := TRUE;
            end;
            inc(i);
        end;
        if not (curWord = ' ') then
            newLine := newLine + curWord + ' ';
    end;
    replaceWordsInLine := newLine;
end;

procedure createNewStory(fromFileName, toFileName : string);
var
    inFile, outFile : TEXT;
    line : string;
    newLine : string;
begin
    assign(inFile, fromFileName);
    assign(outFile, toFileName);
    reset(inFile);
    rewrite(outFile); // overwrite if file exists
    while not eof(inFile) do begin
        readln(inFile, line);
        newLine := replaceWordsInLine(line);
        writeln(outFile, newLine);
    end;
    close(inFile);
    close(outFile);
end;


var
    repls : string;
    fromFileName, toFileName : string;
    i : integer;
    
begin
    fromFileName := '';
    toFileName := '';
    i := 0;
    if not (paramCount = 3) then begin
        writeLn('Usage: StoryGen REPLACEMENTFILE OLDSTORYFILE NEWSTORYFILE');
        halt;
    end;

    repls := paramStr(1);
    fromFileName := paramStr(2);
    toFileName := paramStr(3);

    if not fileExists(repls) then begin
        writeln('Replacement file does not exist!');
        halt;
    end;
    if not fileExists(fromFileName) then begin
        writeln('Old story file does not exist!');
        halt;
    end;
    
    parseRepls(repls);
    createNewStory(fromFileName, toFileName);
    writeLn('Wrote story just for you <3');
    
end.
