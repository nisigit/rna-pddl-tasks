(define (problem problem-ext-1)
    (:domain domain-ext)

    (:objects 
        the-mailbot - mailbot
        the-delbot - delbot
        the-scanner - scanner
        the-switch - button
        the-charger - charger
        p001 - lightpack
        p010 - lightpack 
        p011 - heavypack 

        the-belt - belt

        cell-1-1 cell-1-2 cell-1-3 cell-1-4 cell-1-5 - cell
        cell-2-1 cell-2-2 cell-2-3 - cell
        cell-3-1 cell-3-2 cell-3-3 cell-3-4 cell-3-5 - cell
        cell-4-1 cell-4-2 cell-4-3 cell-4-4 cell-4-5 - cell
        cell-5-1 cell-5-2 cell-5-3 cell-5-4 cell-5-5 - cell
    )

    (:init
        ; Delivery bot
        (at the-delbot cell-1-5)
        (not (holding the-delbot))
        ;Delbot battery
        (= (battery-level the-delbot ) 10)
        
        ; Mailbot
        (at the-mailbot cell-3-3)
        (not (holding the-mailbot))
        ; Mailbot battery
        (= (battery-level the-mailbot) 10)

        ; Scanner
        (at the-scanner cell-1-1)

        ; belt/button is off
        (at the-switch cell-3-5)
        (not (switch-on the-switch))

        ; charger
        (at the-charger cell-3-1)

        ; packages
        (at p001 cell-5-1)
        (at p010 cell-5-3)
        (at p011 cell-5-5)
        (not (scanned p001))
        (not (scanned p010))
        (not (scanned p011))

        (not (on-belt p001))
        (not (on-belt p010))
        (not (on-belt p011))

        ; row adjacency
        (adj cell-1-1 cell-1-2) (adj cell-1-2 cell-1-1)
        (adj cell-1-3 cell-1-4) (adj cell-1-4 cell-1-3)
        (adj cell-1-4 cell-1-5) (adj cell-1-5 cell-1-4)
        (adj cell-2-1 cell-2-2) (adj cell-2-2 cell-2-1)
        (adj cell-2-2 cell-2-3) (adj cell-2-3 cell-2-2)
        (adj cell-3-1 cell-3-2) (adj cell-3-2 cell-3-1)
        (adj cell-3-2 cell-3-3) (adj cell-3-3 cell-3-2)
        (adj cell-3-3 cell-3-4) (adj cell-3-4 cell-3-3)
        (adj cell-3-4 cell-3-5) (adj cell-3-5 cell-3-4)
        (adj cell-4-1 cell-4-2) (adj cell-4-2 cell-4-1)
        (adj cell-4-2 cell-4-3) (adj cell-4-3 cell-4-2)
        (adj cell-4-3 cell-4-4) (adj cell-4-4 cell-4-3)
        (adj cell-4-4 cell-4-5) (adj cell-4-5 cell-4-4)
        (adj cell-5-1 cell-5-2) (adj cell-5-2 cell-5-1)
        (adj cell-5-2 cell-5-3) (adj cell-5-3 cell-5-2)
        (adj cell-5-3 cell-5-4) (adj cell-5-4 cell-5-3)
        (adj cell-5-4 cell-5-5) (adj cell-5-5 cell-5-4)

        ; same column adjacency
        (adj cell-1-1 cell-2-1) (adj cell-2-1 cell-1-1)
        (adj cell-3-1 cell-4-1) (adj cell-4-1 cell-3-1)
        (adj cell-4-1 cell-5-1) (adj cell-5-1 cell-4-1)
        (adj cell-1-2 cell-2-2) (adj cell-2-2 cell-1-2)
        (adj cell-3-2 cell-4-2) (adj cell-4-2 cell-3-2)
        (adj cell-4-2 cell-5-2) (adj cell-5-2 cell-4-2)
        (adj cell-1-3 cell-2-3) (adj cell-2-3 cell-1-3)
        (adj cell-2-3 cell-3-3) (adj cell-3-3 cell-2-3)
        (adj cell-3-3 cell-4-3) (adj cell-4-3 cell-3-3)
        (adj cell-4-3 cell-5-3) (adj cell-5-3 cell-4-3)
        (adj cell-3-4 cell-4-4) (adj cell-4-4 cell-3-4)
        (adj cell-4-4 cell-5-4) (adj cell-5-4 cell-4-4)
        (adj cell-3-5 cell-4-5) (adj cell-4-5 cell-3-5)
        (adj cell-4-5 cell-5-5) (adj cell-5-5 cell-4-5)

        ; adjacent to belt
        (adj cell-1-4 the-belt) 
        (adj cell-1-5 the-belt) 
        (adj cell-2-3 the-belt) 
        (adj cell-3-4 the-belt) 
        (adj cell-3-5 the-belt) 
    )

    (:goal (and (scanned p011)
                (on-belt p011)
                (switch-on the-switch)
    ))

)
