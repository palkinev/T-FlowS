!==============================================================================!
  subroutine Residual_Vector(n, nb, mat_a, x, r1) 
!------------------------------------------------------------------------------!
!   Calculates residual vector.                                                !
!------------------------------------------------------------------------------!
!----------------------------------[Modules]-----------------------------------!
  use Comm_Mod
  use Matrix_Mod
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  integer           :: n, nb
  type(Matrix_Type) :: mat_a
  real              :: x(-nb:n), r1(n)  !  [A]{x}={r1}
!-----------------------------------[Locals]-----------------------------------!
  integer  :: i, j, k, sub
!==============================================================================!

  !----------------!
  !   r = b - Ax   !
  !----------------!
  do i = 1, n
    do j = mat_a % row(i), mat_a % row(i+1) - 1     
      k = mat_a % col(j)                 
      r1(i) = r1(i) - mat_a % val(j) * x(k)  
    end do
  end do

! call exchange(x) 

  do sub = 1, n_proc
    if(nbb_e(sub)  <=  nbb_s(sub)) then
      do k = nbb_s(sub), nbb_e(sub), -1
        i = buffer_index(k)
        r1(i) = r1(i) - mat_a % bou(k) * x(k)
      end do
    end if
  end do

  end subroutine
