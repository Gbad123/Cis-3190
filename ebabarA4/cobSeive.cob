identification division.
program-id. cobSeive.
environment division.
input-output section.
file-control.
  select file-name assign to 'output.txt'
  organization is line sequential.

*> declaration
data division.
working-storage section.
  01 f-data             pic 9(10).
  77 is-valid-input   pic 9.
  77 flag             pic 9.
  77 n                pic 9(10).
  77 i                pic 9(10).
  77 j                pic 9(10).
  77 i-sqr            pic 9(30).

  01  primes-table.
    05 is-prime        pic 9 value 1   occurs 1 to 1000000000 times
                                                    depending on n.

procedure division.
*> drfault values
  move 0 to is-valid-input.
  move 0 to flag.
  move 1 to n.

  perform until is-valid-input = 1
*> user data
    display "Enter the max range/limit or 0 to end"
    accept n
    if n > 0 then
      move 1 to is-valid-input
    else if n = 0 then
      move 1 to is-valid-input
      move 1 to flag
    else
      display "invalid input"
      move 0 to is-valid-input
      move 0 to flag
    end-if
  end-perform.

*> 0 should not go in here
  if flag > 0
    move 2 to i
    compute i-sqr = i * i
    perform until i-sqr > n
*> searching for primes from i
      if is-prime(i) = 1 then
        compute j = i * 2
        perform until j > n
*> setting non primes to 0
          move 0 to is-prime(j)
          add i to j
        end-perform
      end-if
      add 1 to i
      compute i-sqr = i * i
    end-perform
  end-if.

*> printing to a file
  open file-name.
  write "in cobol"
  if n > 1 then
    move 1 to i
    perforn until i > n
*> prime 1 means the number is prime
      if is-prime(i) = 1 then
        move i to f-data
        write f-data
      end-if
      add 1 to i
    end perform
  end-if.
  write "end cobol".
  close file-name.

stop-run.
