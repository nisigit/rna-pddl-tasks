(define (domain mailbot-world-domain)

    (:requirements :adl)

    (:types scanner package button mailbot area - object
        cell - area
        belt - area
    )

    (:predicates
        (at ?p1 - object ?p2 - cell)
        (adj ?cell1 - area ?cell2 - area)    
        (switch-on ?button - button)
        (scanned ?package - package)
        (holding ?what - object)
        (holding-pac ?mailbot - mailbot)
        (holding-scan ?mailbot - mailbot)
        (on-belt ?package - package)
    )

;; Actions

(:action move-mailbot
    :parameters (?who - mailbot ?from - cell ?to - cell)
    :precondition (and (at ?who ?from)
                       (adj ?from ?to)
    )
    :effect (and (not (at ?who ?from))
                 (at ?who ?to)
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
                 (not (at ?what ?where)))
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