!==============================================================================!
  subroutine Save_Scalar(grid, in_1, in_2, var_name, plot_inside, val, fs, fp)
!------------------------------------------------------------------------------!
!   Writes one real scalar defined over cells.                                 !
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  type(Grid_Type)  :: grid
  character(len=*) :: in_1, in_2
  character(len=*) :: var_name
  logical          :: plot_inside     ! plot results inside?
  real             :: val(-grid % n_bnd_cells:grid % n_cells)
  integer          :: fs, fp          ! file unit sequential and parallel
!-----------------------------------[Locals]-----------------------------------!
  integer :: c, c2, s
!==============================================================================!

  ! Header
  if(n_proc > 1 .and. this_proc .eq. 1) then
    write(fs,'(4a)') in_1,                                 & 
                     '<PDataArray type="Float64" Name="',  &
                     trim(var_name),                       &
                     '" format="ascii"/>'
  end if
  write(fp,'(4a)') in_1,                                & 
                   '<DataArray type="Float64" Name="',  &
                   trim(var_name),                      &
                   '" format="ascii">'

  ! Data
  if(plot_inside) then
    do c = 1, grid % n_cells - grid % comm % n_buff_cells
      write(fp,'(a,1pe16.6e4)') in_2, val(c)
    end do
  else
    do s = 1, grid % n_faces
      c2 = grid % faces_c(2,s)
      if( c2 < 0 ) then
        write(fp,'(a,1pe16.6e4)') in_2, val(c2)
      end if
    end do
  end if

  ! Footer
  write(fp,'(a,a)') in_1, '</DataArray>'

  end subroutine
