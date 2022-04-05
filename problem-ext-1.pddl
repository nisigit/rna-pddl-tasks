(define (problem problem-ext-1)
    (:domain domain-ext)

    (:objects 
        the-mailbot - mailbot
        the-scanner - scanner
        the-switch - button
        the-charger - charger
        p001 - package 
        p010 - package
        p011 - package

        the-belt - belt

        cell11 cell12 cell13 cell14 cell15 - cell
        cell21 cell22 cell23 - cell
        cell31 cell32 cell33 cell34 cell35 - cell
        cell41 cell42 cell43 cell44 cell45 - cell
        cell51 cell52 cell53 cell54 cell55 - cell
    )

    (:init
        ; Mailbot
        (at the-mailbot cell33)
        (not (holding-pac the-mailbot))
        (not (holding-scan the-mailbot))
        (not (holding the-scanner))
        (not (holding p001))
        (not (holding p010))
        (not (holding p011))

        ; Mailbot battery
        (= (battery-level the-mailbot) 10)

        ; Scanner
        (at the-scanner cell11)

        ; belt/button is off
        (at the-switch cell35)
        (not (switch-on the-switch))

        ; charger
        (at the-charger cell31)

        ; packages
        (at p001 cell51)
        (at p010 cell53)
        (at p011 cell55)
        (not (scanned p001))
        (not (scanned p010))
        (not (scanned p011))

        (not(on-belt p001))
        (not(on-belt p010))
        (not(on-belt p011))

        ; row adjacency
        (adj c11 c12) (adj c12 c11)
        (adj c13 c14) (adj c14 c13)
        (adj c14 c15) (adj c15 c14)
        (adj c21 c22) (adj c22 c21)
        (adj c22 c23) (adj c23 c22)
        (adj c31 c32) (adj c32 c31)
        (adj c32 c33) (adj c33 c32)
        (adj c33 c34) (adj c34 c33)
        (adj c34 c35) (adj c35 c34)
        (adj c41 c42) (adj c42 c41)
        (adj c42 c43) (adj c43 c42)
        (adj c43 c44) (adj c44 c43)
        (adj c44 c45) (adj c45 c44)
        (adj c51 c52) (adj c52 c51)
        (adj c52 c53) (adj c53 c52)
        (adj c53 c54) (adj c54 c53)
        (adj c54 c55) (adj c55 c54)

        ; same column adjacency
        (adj c11 c21) (adj c21 c11)
        (adj c31 c41) (adj c41 c31)
        (adj c41 c51) (adj c51 c41)
        (adj c12 c22) (adj c22 c12)
        (adj c32 c42) (adj c42 c32)
        (adj c42 c52) (adj c52 c42)
        (adj c13 c23) (adj c23 c13)
        (adj c23 c33) (adj c33 c23)
        (adj c33 c43) (adj c43 c33)
        (adj c43 c53) (adj c53 c43)
        (adj c34 c44) (adj c44 c34)
        (adj c44 c54) (adj c54 c44)
        (adj c35 c45) (adj c45 c35)
        (adj c45 c55) (adj c55 c45)

        ; adjacent to belt
        (adj c14 the-belt)
        (adj c15 the-belt)
        (adj c23 the-belt)
        (adj c34 the-belt)
        (adj c35 the-belt)

    )

    (:goal (and (scanned p001)
                (on-belt p001)
                (scanned p010)
                (on-belt p010)
                (switch-on the-switch)
    ))

)