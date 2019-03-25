program TicTacToe
  implicit none

  character, dimension(3,3) :: tictac

  write(*,*)'Play TIC-TAC-TOE'
  write(*,*)'Enter 1-9 to play'
  write(*,*)' '
  write(*,*)' 1 | 2 | 3 '
  write(*,*)'---+---+---'
  write(*,*)' 4 | 5 | 6 '
  write(*,*)'---+---+---'
  write(*,*)' 7 | 8 | 9 '
  write(*,*)' '

  tictac(1,1) = ' '
  tictac(2,1) = ' '
  tictac(3,1) = ' '
  tictac(1,2) = ' '
  tictac(2,2) = ' '
  tictac(3,2) = ' '
  tictac(1,3) = ' '
  tictac(2,3) = ' '
  tictac(3,3) = ' '

  call playTicTacToe(tictac)
  write(*,*)'Ending: Thanks for playing'
end

subroutine chkovr(tictac, over, winner)
  implicit none
  character, dimension(3,3) :: tictac(3,3)
  logical over
  character winner
  character * 1 blank, draw
  parameter (blank = ' ', draw = 'D')
  logical same
  logical dSame
  integer ir, ic
  over = .true.

  do ir = 1,3
    if (same(tictac(ir,1), tictac(ir,2), tictac(ir,3))) then
      winner = tictac(ir,1)
      return
    end if
  end do
  do ic = 1,3
    if (same(tictac(1,ic), tictac(2,ic), tictac(3,ic))) then
      winner = tictac(1,ic)
      return
    end if
  end do

  dsame = same(tictac(1,1), tictac(2,2), tictac(3,3)) .or. same(tictac(1,3), tictac(2,2), tictac(3,1))
  if(dsame) then
    winner = tictac(2,2)
    return
  end if

  do ir = 1,3
    do ic = 1,3
      if(tictac(ir,ic) == blank) then
        over = .false.
        return
      end if
    end do
  end do

  winner = draw
  return

end subroutine chkovr

logical function chkplay(tictac, move)
  implicit none
  character, dimension(3,3) :: tictac(3,3)
  integer :: move

  if (move == 1) then
    if (tictac(1,1) == ' ') then
      chkplay = .true.
    else
      chkplay = .false.
    end if
  else if (move == 2) then
    if (tictac(1,2) == ' ') then
      chkplay = .true.
    else
      chkplay = .false.
    end if
  else if (move == 3) then
    if (tictac(1,3) == ' ') then
      chkplay = .true.
    else
      chkplay = .false.
    end if
  else if (move == 4) then
    if (tictac(2,1) == ' ') then
      chkplay = .true.
    else
      chkplay = .false.
    end if
  else if (move == 5) then
    if (tictac(2,2) == ' ') then
      chkplay = .true.
    else
      chkplay = .false.
    end if
  else if (move == 6) then
    if (tictac(2,3) == ' ') then
      chkplay = .true.
    else
      chkplay = .false.
    end if
  else if (move == 7) then
    if (tictac(3,1) == ' ') then
      chkplay = .true.
    else
      chkplay = .false.
    end if
  else if (move == 8) then
    if (tictac(3,2) == ' ') then
      chkplay = .true.
    else
      chkplay = .false.
    end if
  else if (move == 9) then
    if (tictac(3,3) == ' ') then
      chkplay = .true.
    else
      chkplay = .false.
      end if
  else
    chkplay = .false.
  end if

end function chkplay

subroutine showBoard(tictac)
  implicit none
  character, dimension(3,3) :: tictac(3,3)

  write(*,*)' '
  write(*,*)' ',tictac(1,1), ' | ', tictac(1,2), ' | ', tictac(1,3), ' '
  write(*,*)'---+---+---'
  write(*,*)' ',tictac(2,1), ' | ', tictac(2,2), ' | ', tictac(2,3), ' '
  write(*,*)'---+---+---'
  write(*,*)' ',tictac(3,1), ' | ', tictac(3,2), ' | ', tictac(3,3), ' '
  write(*,*)' '

end subroutine showBoard

integer function getMove(tictac)
  implicit none
  character, dimension(3,3) :: tictac(3,3)
  character :: thing
  logical :: chkplay
  integer :: flag
  integer :: num
  integer, dimension(9) :: x = (/1,2,3,4,5,6,7,8,9/)
  flag = 0

  do while (flag == 0)
    read(*,*) thing
    num = iachar(thing)
    if(any(x == (num - 48))) then
      num = num - 48
      if(chkplay(tictac, num)) then
        flag = 1
      else
        flag = 0
      end if
    else
      write(*,*)'Invlid move, Try again'
      write(*,*)' '
    end if
  end do
  getMove =  num
  return

end function getMove


logical function same(num1, num2, num3)
  implicit none
  character num1,num2,num3

  if(num1 == 'X' .and. num2 == 'X' .and. num3 == 'X') then
    same = .true.
  else if(num1 == 'O' .and. num2 == 'O' .and. num3 == 'O') then
    same = .true.
  else
    same = .false.
  end if

end function same

subroutine playTicTacToe(tictac)
  implicit none
  character, dimension(3,3) :: tictac(3,3)
  character winner
  logical :: over
  integer :: turn
  integer :: move
  integer :: getMove
  winner = ' '
  turn = 0

  over = .false.

  do while(over .neqv. .true.)
    if(turn == 0) then
      move = getMove(tictac)
      if(move == 1) then
        tictac(1,1) = 'X'
      else if(move == 2) then
        tictac(1,2) = 'X'
      else if(move == 3) then
        tictac(1,3) = 'X'
      else if(move == 4) then
        tictac(2,1) = 'X'
      else if(move == 5) then
        tictac(2,2) = 'X'
      else if(move == 6) then
        tictac(2,3) = 'X'
      else if(move == 7) then
        tictac(3,1) = 'X'
      else if(move == 8) then
        tictac(3,2) = 'X'
      else if(move == 9) then
        tictac(3,3) = 'X'
      else
        write(*,*)'Error Invalid input'
        return
      end if
      turn = 1
    else
      write(*,*)'Computers turn'
      write(*,*)' '
      turn = 0
    end if
    call showBoard(tictac)
    call chkovr(tictac, over, winner)
  end do

  if(winner == 'X') then
    write(*,*)'Player wins'
  else if(winner == 'O')then
    write(*,*)'Computer wins'
  else if(winner == 'D')then
    write(*,*)'Draw'
  else
    write(*,*)'Error: Something went very wrong'
  end if
  return

end subroutine playTicTacToe
