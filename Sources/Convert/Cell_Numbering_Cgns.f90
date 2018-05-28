!==============================================================================!
!                                   cgns_hex                                   !
!                                                                              !
!                      8-----------7             8-----------7                 !
!                     /|          /|            /|          /|                 !
!                    /           / |           /    (6)    / |                 !
!                   /  |    (4) /  |          /  |        /  |                 !
!                  5-----------6   |         5-----------6   |                 !
!                  |(5)|       |(3)|         |   |       |   |                 !
!                  |   4- - - -|- -3         |   4- - - -|- -3                 !
!                  |  / (2)    |  /          |  /        |  /                  !
!                  |           | /           |      (1)  | /                   !
!                  |/          |/            |/          |/                    !
!                  1-----------2             1-----------2                     !
!                                                                              !
!                  (1), (5) and (4) are behind                                 !
!------------------------------------------------------------------------------!
!                                  cgns_tet                                    !
!                                                                              !
!                          4-----3                   4-----3                   !
!                         / \  .'|                  / \  .'|                   !
!                        /(4)\(3)|                 /   \'  |                   !
!                       /  .' \  |                /  .' \  |                   !
!                      / .' (1)\ |               / .(2)  \ |                   !
!                     /.'       \|              /.'       \|                   !
!                    1-----------2             1-----------2                   !
!                                                                              !
!                    (1) and (4) are behind                                    !
!------------------------------------------------------------------------------!
!                                 cgns_wed                                     !
!                                                                              !
!                        6.                        6.                          !
!                       /| `.                     /| `.                        !
!                      /     `.                  / (5) `.                      !
!                     /  |     `.               /  |     `.                    !
!                    4-----------5             4-----------5                   !
!                    |(3)|  (2)  |             |   |       |                   !
!                    |   3.      |             |   3.      |                   !
!                    |  / (1)    |             |  /  `.    |                   !
!                    |       `.  |             |   (4) `.  |                   !
!                    |/        `.|             |/        `.|                   !
!                    1-----------2             1-----------2                   !
!                                                                              !
!                    (2), (3) and (4) are behind                               !
!                                                                              !
!------------------------------------------------------------------------------!
!                                  cgns_pyr                                    !
!                                                                              !
!                                     .5.                                      !
!                                   .'/ \`.                                    !
!                                 .' /   \ `.                                  !
!                               .'  / (4) \  `.                                !
!                             .'(5)/       \(3)`.                              !
!                           4' - -/- - - - -\- - `3                            !
!                           |    /    (2)    \    |                            !
!                           |   /             \   |                            !
!                           |  /      (1)      \  |                            !
!                           | /                 \ |                            !
!                           |/                   \|                            !
!                           1---------------------2                            !
!                                                                              !
!                           (4) is behind                                      !
!                                                                              !
!------------------------------------------------------------------------------!
!   Note:
! 
!   cgns_tet, cgns_pyr, cgns_wed and cgns_hex hold -1 where unused 
!==============================================================================!

  integer cgns_hex(6,4), cgns_tet(6,4), cgns_wed(6,4), cgns_pyr(6,4)

  data cgns_tet / 1, 1, 2, 3,-1,-1,  &
                  3, 2, 3, 1,-1,-1,  &
                  2, 4, 4, 4,-1,-1,  & 
                 -1,-1,-1,-1,-1,-1  /

  data cgns_hex / 1, 1, 2, 3, 1, 5,  &
                  4, 2, 3, 4, 5, 6,  &
                  3, 6, 7, 8, 8, 7,  &
                  2, 5, 6, 7, 4, 8   / 

  data cgns_wed / 1, 2, 3, 1, 4,-1,  &
                  2, 3, 1, 3, 5,-1,  &
                  5, 6, 4, 2, 6,-1,  &
                  4, 5, 6,-1,-1,-1   / 

  data cgns_pyr / 1, 1, 2, 3, 4,-1,  &
                  4, 2, 3, 4, 1,-1,  &
                  3, 5, 5, 5, 5,-1,  &
                  2,-1,-1,-1,-1,-1   / 
