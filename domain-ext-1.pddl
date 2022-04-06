(define (domain domain-ext-1)

    (:requirements :adl :fluents)

    (:types cell button mailbot belt charger pickable - object
        scanner - pickable
        package - pickable
    )

    (:predicates
        (at ?p1 ?p2)
        (adj ?cell1 - cell ?cell2)    
        (switch-on ?button - button)
        (scanned ?package - package)
        (holding ?what)
        (holding-pac ?mailbot - mailbot)
        (holding-scan ?mailbot - mailbot)
        (on-belt ?package - package)
    )

    (:functions
        (battery-level ?who - mailbot)
    )

;; Actions

(:action recharge-bot
    :parameters (?who - mailbot ?where - cell ?with - charger)
    :precondition (and (at ?who ?where)
                       (at ?with ?where)
    )
    :effect (and (assign (battery-level ?who) 15))
)

(:action move-mailbot
    :parameters (?who - mailbot ?from - cell ?to - cell)
    :precondition (and (at ?who ?from)
                       (adj ?from ?to)
                       (or 
                            (and 
                                (or (holding-pac ?who) (holding-scan ?who)) 
                                (>= (battery-level ?who) 2)
                            )
                            (and (not (holding-pac ?who)) 
                                (not (holding-scan ?who))
                                (>= (battery-level ?who) 1)
                            )
                        )
    )
    :effect (and (at ?who ?to)
                 (not (at ?who ?from))
                 (when (or (holding-pac ?who) (holding-scan ?who))
                       (decrease (battery-level ?who) 2)
                 )
                 (when (not (or (holding-pac ?who) (holding-scan ?who)))
                       (decrease (battery-level ?who) 1)
                 )
    )
)


(:action pick-scanner
    :parameters (?who - mailbot ?what - scanner ?where - cell)
    :precondition (and (at ?who ?where)
                       (at ?what ?where)
                       (not (holding ?what))
                       (not (holding-pac ?who))
                       (not (holding-scan ?who))
    )
    :effect (and (holding ?what)
                 (holding-scan ?who)
                 (not (at ?what ?where))
    )
)


(:action pick-package
    :parameters (?who - mailbot ?what - package ?where - cell)
    :precondition (and (at ?what ?where)
                       (at ?who ?where)
                       (not (holding ?what))
                       (not (holding-pac ?who))
                       (not (holding-scan ?who))
    )
    :effect (and (holding ?what)
                 (holding-pac ?who)
                 (not (at ?what ?where)))
)

    
(:action drop
    :parameters (?who - mailbot ?where - cell ?what)
    :precondition (and (at ?who ?where)
                       (holding ?what)
    )
    :effect (and (not (holding ?what))
                 (at ?what ?where)
                 (not(holding-pac ?who))
                 (not(holding-scan ?who)))
)


(:action scan
    :parameters (?who - mailbot ?what - package ?where - cell ?scanner - scanner)
    :precondition (and (at ?who ?where)
                       (at ?what ?where)
                       (holding-scan ?who)
                       (holding ?scanner)
                       (not(scanned ?what)))
    :effect (and (scanned ?what))
)
    
    
(:action switch-belt-on
    :parameters (?who - mailbot ?where - cell ?button - button)
    :precondition (and (not (switch-on ?button))
                       (at ?who ?where)
                       (at ?button ?where))
    :effect (and (switch-on ?button)
    )
)

    
(:action place-on-belt
    :parameters (?who - mailbot ?what - package ?where - cell ?belt - belt)
    :precondition (and (at ?who ?where)
                       (adj ?where ?belt) 
                       (scanned ?what)
                       (holding ?what)
    )
    :effect (and (on-belt ?what)
                 (not (holding ?what))
                 (not (holding-pac ?who))
    )
)

)