!======================================================================!
  subroutine Swap_Int(a, b)
!----------------------------------------------------------------------!
!   Swaps two integers.                                                !
!----------------------------------------------------------------------!
  implicit none
!-----------------------------[Arguments]------------------------------!
  integer :: a, b            
!-------------------------------[Locals]-------------------------------!
  integer :: t
!======================================================================!

  t = a
  a = b
  b = t

  end subroutine
