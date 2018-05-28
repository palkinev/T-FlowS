!==============================================================================!
  subroutine Comm_Mod_Allocate_Memory(grid)
!------------------------------------------------------------------------------!
!----------------------------------[Modules]-----------------------------------!
  use Grid_Mod
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  type(Grid_Type) :: grid
!==============================================================================!

  allocate (buffer_index(-grid % n_bnd_cells:-1)); buffer_index=0
 
  end subroutine
