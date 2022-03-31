(define (problem problem-1)
    (:domain mailbot-world-domain)

    (:objects 
        the-mailbot - mailbot
        the-scanner - scanner
        the-switch - button
        p001 - package 
        p010 - package
        p011 - package

        belt-4-1 - belt
        belt-5-1 - belt

        cell-1-1 cell-1-2 cell-1-3 cell-1-4 cell-1-5 - cell
        cell-2-1 cell-2-2 cell-2-3 cell-2-4 cell-2-5 - cell
        cell-3-1 cell-3-2 cell-3-3 cell-3-4 cell-3-5 - cell
        cell-4-2 cell-4-3 cell-4-4 cell-4-5 - cell
        cell-5-2 cell-5-3 cell-5-4 cell-5-5 - cell
    )

    (:init
        ; Mailbot
        (at the-mailbot cell-5-2)
        (not (holding-pac the-mailbot))
        (not (holding-scan the-mailbot))
        (not (holding the-scanner))
        (not (holding p001))
        (not (holding p010))
        (not (holding p011))

        ; Scanner
        (at the-scanner cell-5-5)

        ; belt/button is off
        (at the-switch cell-1-1)
        (not (switch-on the-switch))

        ; packages
        (at p001 cell-1-5)
        (at p010 cell-5-4)
        (at p011 cell-2-1)
        (not (scanned p001))
        (not (scanned p010))
        (not (scanned p011))

        (not(on-belt p001))
        (not(on-belt p010))
        (not(on-belt p011))

        ; row adjacency
        (adj cell-1-1 cell-1-2) (adj cell-1-2 cell-1-1)
        (adj cell-1-2 cell-1-3) (adj cell-1-3 cell-1-2)
        (adj cell-1-3 cell-1-4) (adj cell-1-4 cell-1-3)
        ; (adj cell-1-4 cell-1-5) (adj cell-1-5 cell-1-4)
        (adj cell-2-1 cell-2-2) (adj cell-2-2 cell-2-1)
        (adj cell-2-2 cell-2-3) (adj cell-2-3 cell-2-2)
        (adj cell-2-3 cell-2-4) (adj cell-2-4 cell-2-4)
        (adj cell-2-4 cell-2-5) (adj cell-2-5 cell-2-4)
        (adj cell-3-1 cell-3-2) (adj cell-3-2 cell-3-1)
        (adj cell-3-2 cell-3-3) (adj cell-3-3 cell-3-2)
        ; (adj cell-3-3 cell-3-4) (adj cell-3-4 cell-3-3)
        ; (adj cell-3-4 cell-3-5) (adj cell-3-5 cell-3-4)
        ; (adj cell-4-1 cell-4-2) (adj cell-4-2 cell-4-1)
        (adj cell-4-2 cell-4-3) (adj cell-4-3 cell-4-2)
        (adj cell-4-3 cell-4-4) (adj cell-4-4 cell-4-3)
        ; (adj cell-4-4 cell-4-5) (adj cell-4-5 cell-4-4)
        ; (adj cell-5-1 cell-5-2) (adj cell-5-2 cell-5-1)
        ; (adj cell-5-2 cell-5-3) (adj cell-5-3 cell-5-2)
        (adj cell-5-3 cell-5-4) (adj cell-5-4 cell-5-3)
        ; (adj cell-5-4 cell-5-5) (adj cell-5-5 cell-5-4)

        ; same column adjacency

        ; (adj cell-1-1 cell-2-1) (adj cell-2-1 cell-1-1)
        (adj cell-2-1 cell-3-1) (adj cell-3-1 cell-2-1)
        ; (adj cell-3-1 cell-4-1) (adj cell-4-1 cell-3-1)
        ; (adj cell-4-1 cell-5-1) (adj cell-5-1 cell-4-1)
        ; (adj cell-1-2 cell-2-2) (adj cell-2-2 cell-1-2)
        (adj cell-2-2 cell-3-2) (adj cell-3-2 cell-2-2)
        ; (adj cell-3-2 cell-4-2) (adj cell-4-2 cell-3-2)
        (adj cell-4-2 cell-5-2) (adj cell-5-2 cell-4-2)
        ; (adj cell-1-3 cell-2-3) (adj cell-2-3 cell-1-3)
        ; (adj cell-2-3 cell-3-3) (adj cell-3-3 cell-2-3)
        (adj cell-3-3 cell-4-3) (adj cell-4-3 cell-3-3)
        (adj cell-4-3 cell-5-3) (adj cell-5-3 cell-4-3)
        (adj cell-1-4 cell-2-4) (adj cell-2-4 cell-1-4)
        (adj cell-2-4 cell-3-4) (adj cell-3-4 cell-2-4)
        (adj cell-3-4 cell-4-4) (adj cell-4-4 cell-3-4)
        (adj cell-4-4 cell-5-4) (adj cell-5-4 cell-4-4)
        (adj cell-1-5 cell-2-5) (adj cell-2-5 cell-1-5)
        (adj cell-2-5 cell-3-5) (adj cell-3-5 cell-2-5)
        (adj cell-3-5 cell-4-5) (adj cell-4-5 cell-3-5)
        (adj cell-4-5 cell-5-5) (adj cell-5-5 cell-4-5)

        ; adjacent to belt
        (adj cell-4-2 belt-4-1)
        (adj cell-5-2 belt-5-1)
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
