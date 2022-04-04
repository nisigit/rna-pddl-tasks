(define (problem problem-1)
    (:domain mailbot-world-domain)

    (:objects 
        the-mailbot - mailbot
        the-scanner - scanner
        the-switch - button
        p001 - package 
        p010 - package
        p011 - package

        the-belt - belt

        c11 c12 c13 c14 c15 - cell
        c21 c22 c23 c24 c25 - cell
        c31 c32 c33 c34 c35 - cell
        c42 c43 c44 c45 - cell
        c52 c53 c54 c55 - cell
    )

    (:init
        ; Mailbot
        (at the-mailbot c52)
        (not (holding-pac the-mailbot))
        (not (holding-scan the-mailbot))
        (not (holding the-scanner))
        (not (holding p001))
        (not (holding p010))
        (not (holding p011))

        ; Scanner
        (at the-scanner c55)

        ; belt/button is off
        (at the-switch c11)
        (not (switch-on the-switch))

        ; packages
        (at p001 c15)
        (at p010 c54)
        (at p011 c21)
        (not (scanned p001))
        (not (scanned p010))
        (not (scanned p011))

        (not (on-belt p001))
        (not (on-belt p010))
        (not (on-belt p011))

        ; row adjacency
        (adj c11 c12) (adj c12 c11)
        (adj c12 c13) (adj c13 c12)
        (adj c13 c14) (adj c14 c13)
        (adj c21 c22) (adj c22 c21)
        (adj c22 c23) (adj c23 c22)
        (adj c23 c24) (adj c24 c24)
        (adj c24 c25) (adj c25 c24)
        (adj c31 c32) (adj c32 c31)
        (adj c32 c33) (adj c33 c32)
        (adj c42 c43) (adj c43 c42)
        (adj c43 c44) (adj c44 c43)
        (adj c53 c54) (adj c54 c53)

        ; same column adjacency

        (adj c21 c31) (adj c31 c21)
        (adj c22 c32) (adj c32 c22)
        (adj c42 c52) (adj c52 c42)
        (adj c33 c43) (adj c43 c33)
        (adj c43 c53) (adj c53 c43)
        (adj c14 c24) (adj c24 c14)
        (adj c24 c34) (adj c34 c24)
        (adj c34 c44) (adj c44 c34)
        (adj c44 c54) (adj c54 c44)
        (adj c15 c25) (adj c25 c15)
        (adj c25 c35) (adj c35 c25)
        (adj c35 c45) (adj c45 c35)
        (adj c45 c55) (adj c55 c45)

        ; adjacent to belt
        (adj c42 the-belt)
        (adj c52 the-belt)
    )

    (:goal (and (scanned p001)
                (on-belt p001)
                (scanned p011)
                (on-belt p011)
                (scanned p010)
                (on-belt p010)
                (switch-on the-switch)
    ))

)
