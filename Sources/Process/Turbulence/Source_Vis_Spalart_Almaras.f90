!==============================================================================!
  subroutine Source_Vis_Spalart_Almaras(grid, phi_x, phi_y, phi_z)
!------------------------------------------------------------------------------!
!   Computes the source terms in vis transport equation.                       !
!------------------------------------------------------------------------------!
!----------------------------------[Modules]-----------------------------------!
  use Flow_Mod
  use Les_Mod
  use Rans_Mod
  use Grid_Mod
  use Control_Mod
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  type(Grid_Type) :: grid
!-----------------------------------[Locals]-----------------------------------!
  integer           :: c 
  real              :: x_rat, f_v1, f_v2, f_w, ss, dist_v, prod_v, r, gg, Dif
  real              :: dist
  real              :: phi_x(-grid % n_bnd_cells:grid % n_cells),  &
                       phi_y(-grid % n_bnd_cells:grid % n_cells),  &
                       phi_z(-grid % n_bnd_cells:grid % n_cells)
!==============================================================================!

  if(turbulence_model .eq. SPALART_ALLMARAS) then
    do c = 1, grid % n_cells

      !---------------------------------!
      !   Compute the production term   !
      !---------------------------------!
      x_rat  = vis % n(c)/viscosity
      f_v1   = x_rat**3/(x_rat**3 + c_v1**3)
      f_v2   = 1.0 - x_rat/(1.0 + x_rat*f_v1)
      ss     = vort(c) + vis % n(c)*f_v2/(kappa**2*grid % wall_dist(c)**2)
      prod_v = c_b1 * density * ss * vis % n(c)
      b(c)   = b(c) + prod_v * grid % vol(c)

      !----------------------------------!
      !   Compute the destruction term   !
      !----------------------------------!
      r      = vis % n(c)/(ss * kappa**2 * grid % wall_dist(c)**2)
      gg     = r + c_w2*(r**6 - r)
      f_w    = gg*((1.0 + c_w3**6)/(gg**6 + c_w3**6))**(1.0/6.0)
      dist_v = c_w1* density * f_w * (vis % n(c)/grid % wall_dist(c)**2)
      A % val(A % dia(c)) = A % val(A % dia(c)) + dist_v * grid % vol(c)
 
      !--------------------------------------------!
      !   Compute the first-order diffusion term   !
      !--------------------------------------------!
      Dif   = c_b2                                 &
            * density                              &
            * (phi_x(c) + phi_y(c) + phi_z(c))**2  &
            / vis % sigma
      b(c)  = b(c) + Dif * grid % vol(c)
    end do

  else if(turbulence_model .eq. DES_SPALART) then
    do c = 1, grid % n_cells

      ! What is 0.65 here?  A ghost number
      dist = min(grid % wall_dist(c),0.65 * grid % delta(c))

      !---------------------------------!
      !   Compute the production term   !
      !---------------------------------!
      x_rat  = vis % n(c)/viscosity
      f_v1   = x_rat**3/(x_rat**3 + c_v1**3)
      f_v2   = 1.0 - x_rat/(1.0 + x_rat*f_v1)
      ss     = vort(c) + vis % n(c)*f_v2/(kappa**2*dist**2)
      prod_v = c_b1 * density * ss * vis % n(c)
      b(c)   = b(c) + prod_v * grid % vol(c)
      
      !-----------------------------------!
      !   Compute the destruction  term   !
      !-----------------------------------!
      r      = vis % n(c)/(ss * kappa**2 * dist**2)
      gg     = r + c_w2*(r**6 - r)
      f_w    = gg*((1.0 + c_w3**6)/(gg**6 + c_w3**6))**(1.0/6.0)
      dist_v = c_w1* density * f_w * (vis % n(c)/dist**2)
      A % val(A % dia(c)) = A % val(A % dia(c)) + dist_v * grid % vol(c)

      !--------------------------------------------!
      !   Compute the first-order diffusion term   !
      !--------------------------------------------!
      Dif   = c_b2                                 &
            * density                              &
            * (phi_x(c) + phi_y(c) + phi_z(c))**2  &
            / vis % sigma
      b(c)  = b(c) + Dif * grid % vol(c)
    end do 
  end if

  end subroutine
