--ebad babar
--0954164
--sources
--https://www.geeksforgeeks.org/write-a-c-program-to-print-all-permutations-of-a-given-string/
--helped understand not gave code in java which when translated worked for swaps
--https://www2.adacore.com/gap-static/GNAT_Book/html/aarm/AA-A-4-5.html
--provided details on how unbounded things work

with ada.Text_IO; use ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;

procedure jumble is
  --bounded strings one for the dictionary data
  --second for the total number possible combination of 6 letter word
  type dictData is array(1..51245) of unbounded_string;
  type usrData is array(1..720) of unbounded_string;

  function buildLEXICON return dictData is
    infp : file_type;
    tempString : unbounded_string;
    temp : dictData;
      i: integer := 1;

    --reading in the file and storing in unbounded string
    --putting in an array of dictionary data
    begin
      put_line("Build Lexicon");
      open(infp,in_file,"/usr/share/dict/canadian-english-small");
      loop
        exit when end_of_file (infp);
        get_line(infp, tempString);
        if(length(tempString) <= 6) then
          temp(i) := tempString;
          i := i + 1;
        end if;
      end loop;
    close(infp);
    return temp;
  end buildLEXICON;

  function inputJumble return unbounded_string is
    s: unbounded_string;

    --getting user input
    begin
      Put("Enter a word or q to end ");
      get_line(s);
      put_line("Your word " & s);

      --validity check
      if(length(s) > 6) then
        s := to_unbounded_string("");
        put_line("Invalid input");
      end if;
    return s;
  end inputJumble;

  --swaps the character in the string to create all anagrams
  function generateAnagram(str: in out unbounded_string; x: integer; y: integer) return usrData is
  arr : usrData;
  counter : integer := 1;

  --converting to a normal string to soo i can swap if
  --then converting back to an unbounded string
  procedure swap(dataSwap: in out unbounded_string; x: integer; y: integer) is
  ch : character;
  temp : string := to_string(dataSwap);
  begin
    ch := temp(x);
    temp(x) := temp(y);
    temp(y) := ch;
    dataSwap := to_unbounded_string(temp);
    --return to_unbounded_string(temp);
  end swap;

  --calls swap and build the anagram list
  procedure perm(arr : in out usrData; str: in out unbounded_string; x: integer; y: integer; counter: in out integer) is
    begin
      if(x = y) then
        --put_line(str);
        arr(counter) := str;
        counter := counter + 1;
      else
        for i in x..length(str) loop
          swap(str, x, i);
          perm(arr, str, x+1, y, counter);
          swap(str, x, 1);
        end loop;
      end if;
    end perm;

  begin
    perm(arr, str, x, y, counter);
    return arr;
  end generateAnagram;

  procedure findAnagram(dData: dictData; uData: usrData) is
  list : usrData;
  count : integer := 1;
  begin

  --checking to see if match
    for i in uData'Range loop
      for j in dData'Range loop
        if (uData(i) = dData(j)) then
          if(uData(i) /= "") then
            --put_line(uData(i));
            list(count) := uData(i);
            count := count + 1;
            end if;
        end if;
      end loop;
    end loop;

    --printing the found words and freeing memory for later use
    put_line("Word/s found");
    for i in list'Range loop
      if(list(i) /= "") then
        put_line(list(i));
        list(i) := to_unbounded_string("");
      end if;
    end loop;
  end findAnagram;

  --extra declarations
  dData : dictData;
  uData : usrData;
  thing: unbounded_string;
  flag : integer := 0;
  len : integer := 0;

  --main
  begin
    dData := buildLEXICON;
    --for i in dData'Range loop
      --if dData(i) /= "" then
        --put_line("Dictionary word " & dData(i));
      --end if;
    --end loop;

    --do until user wants to end with q
    loop
      thing := inputJumble;
      if(thing = "q") then
        flag := 1;
      end if;
      exit when flag = 1;

      --generating anagram
      len := length(thing);
      --put(len , 0);
      uData := generateAnagram(thing, 1, len);
      --for i in uData'Range loop
        --if uData(i) /= "" then
          --put_line("anagram " & uData(i));
        --end if;
      --end loop;

      --free or clear
      findAnagram(dData, uData);
      for i in uData'Range loop
        uData(i) := to_unbounded_string("");
      end loop;

    end loop;
end jumble;
