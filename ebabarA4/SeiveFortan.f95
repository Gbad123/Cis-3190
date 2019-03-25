program SeiveFortran
  implicit none

  integer :: n, mid, x, flag, i , j, test
  logical, allocatable, dimension(:) :: primes

  integer :: clck_counts_beg, clck_counts_end, clck_rate

  test = 0
  do while (test == 0)
!getting user input
    write(*,*)'Enter the max Range or 0 to end the program'
    read(*,*)n
    if(n == 0)then
      flag = 0
      test = 1
    else
      flag = 1
    end if
    call system_clock ( clck_counts_beg, clck_rate )
!allocating space and making everything true
    allocate(primes(n))
    primes(1:n) = .true.
    mid = n / 2

    if(flag == 1) then
!looking for unchanged values
      do i =2, mid
        if(primes(i))then
          x = n / i
!setting non primes to false
          do j = 2, x
            primes(i*j) = .false.
          end do
        end if
      end do

!writing to a file
!assumes the file already exists
      open(unit = 9, file='output.txt', status='old', position='append', action='write')
      write(9,*)'in fortran'
      do i = 1, n
        if(primes(i))then
          write(9,fmt="(i0)", advance='no')i
          write(9,fmt="(a)", advance='no')', '
        end if
      end do
      write(9,*)' '
      write(9,*)'end fortran'
    end if
!free and time
    deallocate(primes)
    call system_clock ( clck_counts_end, clck_rate )
    write (*, *)  (clck_counts_end - clck_counts_beg) / real (clck_rate)
  end do

end program SeiveFortran
