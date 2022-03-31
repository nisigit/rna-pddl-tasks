(define (problem problem-ext-1)
    (:domain domain-ext)

    (:objects 
        the-mailbot - mailbot
        the-delbot - delbot
        the-scanner - scanner
        the-switch - button
        the-charger - charger
        p001 - smallpac
        p010 - smallpac
        p011 - largepac

        belt-2-4 - belt
        belt-2-5 - belt

        cell-1-1 cell-1-2 cell-1-3 cell-1-4 cell-1-5 - cell
        cell-2-1 cell-2-2 cell-2-3 - cell
        cell-3-1 cell-3-2 cell-3-3 cell-3-4 cell-3-5 - cell
        cell-4-1 cell-4-2 cell-4-3 cell-4-4 cell-4-5 - cell
        cell-5-1 cell-5-2 cell-5-3 cell-5-4 cell-5-5 - cell
    )

    (:init
        ; Delivery bot
        (at the-delbot cell-1-5)
        (not (holding-pac the-delbot))
        (not (holding-scan the-delbot))
        (not (holding the-delbot the-scanner))
        (not (holding the-delbot p001))
        (not (holding the-delbot p010))
        (not (holding the-delbot p011))

        ;Delbot battery
        (= (battery-level the-delbot 10))
        
        ; Mailbot
        (at the-mailbot cell-3-3)
        (not (holding-pac the-mailbot))
        (not (holding-scan the-mailbot))
        (not (holding the-mailbot the-scanner))
        (not (holding the-mailbot p001))
        (not (holding the-mailbot p010))
        (not (holding the-mailbot p011))

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

        (not(on-belt p001))
        (not(on-belt p010))
        (not(on-belt p011))

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
        (adj cell-1-4 belt-2-4) 
        (adj cell-1-5 belt-2-5) 
        (adj cell-2-3 belt-2-4) 
        (adj cell-3-4 belt-2-4) 
        (adj cell-3-5 belt-2-5) 

    )

    (:goal (and (scanned p011)
                (on-belt p011)
                (switch-on the-switch)
    ))

)
