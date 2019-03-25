with ada.Text_IO; use ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with Ada.Calendar; use Ada.Calendar;

procedure sieve is

  --main
  last: integer;
  --creating an array type
  type myArray is array (integer range <>) of boolean;
  base: positive := 2;
  x: positive;
  begin
  last:= -1;
  --getting user input
  loop
    exit when last > -1;
    put("Enter the max range or 0 to end the program");
    new_line;
    get(last);
    new_line;
  end loop;

  declare
  --declaring the size of the array
    Prime : myArray(1..last);
    start_time: time := clock;
    finish_time: time;
    Output: File_Type;
  begin
  --opening the file
    Open(File => Output, Mode => append_file, Name => "output.txt");

    --setting the array to true
    if last /= 0 then
      for i in 2..last loop
        Prime(i) := true;
      end loop;

      loop
        exit when base * base > last;
        --looking for unchange numbers
        if Prime(base) then
          x := base + base;
          loop
          --finding the non prime numbers
            exit when x > last;
            Prime(x) := false;
            x := x + base;
          end loop;
        end if;
        base := base + 1;
      end loop;
      --output to the file
      put(Output, "In ada");
      for n in Prime'Range loop
        if Prime(n) then
          put(Output, positive'image(n));
        end if;
      end loop;
      --time
      put(Output,"end ada");
      finish_time := clock;
      put(duration'image((finish_time-start_time)));
      put(" seconds");
    end if;
  end;
end sieve;
