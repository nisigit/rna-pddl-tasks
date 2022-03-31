(define (domain domain-ext)

    (:requirements :adl :fluents)

    (:types cell button belt charger pickable - object bot - object
        scanner - pickable
        package - pickable
        mailbot - bot 
        delbot - bot
        largepac - package
        smallpac - package
    )

    (:predicates
        (at ?p1 ?p2)
        (adj ?cell1 - cell ?cell2)    
        (switch-on ?button - button)
        (scanned ?package - package)
        (holding ?who - bot ?what - object)
        (holding-pac ?bot - bot)
        (holding-scan ?bot - bot)
        (on-belt ?package - package)
    )

    (:functions
        (battery-level ?who - bot)
    )

;; Actions

(:action recharge-bot
    :parameters (?who - bot ?where - cell ?with - charger)
    :precondition (and (at ?who ?where)
                       (at ?with ?where)
    )
    :effect (and (assign (battery-level ?who) 15))
)

(:action move-bot
    :parameters (?who - bot ?from - cell ?to - cell)
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
    :parameters (?who - bot ?what - scanner ?where - cell)
    :precondition (and (at ?who ?where)
                       (at ?what ?where)
                       (not (holding ?who ?what))
                       (not (holding-pac ?who))
                       (not (holding-scan ?who))
    )
    :effect (and (holding ?who ?what)
                 (holding-scan ?who)
                 (not (at ?what ?where))
    )
)

(:action pick-scanner
    :parameters (?who - bot ?what - scanner ?where - cell)
    :precondition (and (at ?who ?where)
                       (at ?what ?where)
                       (not (holding ?who ?what))
                       (not (holding-pac ?who))
                       (not (holding-scan ?who))
    )
    :effect (and (holding ?who ?what)
                 (holding-pac ?who)
                 (not (at ?what ?where))             
    )
    )
)



(:action pick-small-pack
    :parameters (?who - bot ?what - smallpac ?where - cell)
    :precondition (and (at ?what ?where)
                       (at ?who ?where)
                       (not (holding ?who ?what))
                       (not (holding-pac ?who))
                       (not (holding-scan ?who))
    )
    :effect (and (holding ?who ?what)
                 (holding-pac ?who)
                 (not (at ?what ?where)))
)

(:action pick-large-pack
    :parameters (?mbot - mailbot ?dbot - delbot ?what - largepac ?where - cell)
    :precondition (and (at ?mbot ?where)
                       (at ?dbot ?where)
                       (not (holding ?mbot ?what))
                       (not (holding ?dbot ?what))
                       (not (holding-pac ?mbot))
                       (not (holding-pac ?dbot))
                       (not (holding-scan ?mbot))
                       (not (holding-scan ?dbot))
    )
    :effect (and (holding ?mbot ?what)
                 (holding ?dbot ?what)
                 (holding-pac ?mbot)
                 (holding-pac ?dbot)
                 (not (at ?what ?where))
    )        
)


    
(:action drop
    :parameters (?who - bot ?where - cell ?what)
    :precondition (and (at ?who ?where)
                       (holding ?who ?what)
    )
    :effect (and (not (holding ?who ?what))
                 (at ?what ?where)
                 (not(holding-pac ?who))
                 (not(holding-scan ?who)))
)


(:action scan
    :parameters (?who - mailbot ?what - package ?where - cell ?scanner - scanner)
    :precondition (and (at ?who ?where)
                       (at ?what ?where)
                       (holding-scan ?who)
                       (holding ?who ?scanner)
                       (not(scanned ?what)))
    :effect (and (scanned ?what))
)
    
    
(:action switch-belt-on
    :parameters (?who - bot ?where - cell ?button - button)
    :precondition (and (not (switch-on ?button))
                       (at ?who ?where)
                       (at ?button ?where))
    :effect (and (switch-on ?button)
    )
)

    
(:action place-on-belt
    :parameters (?who - bot ?what - package ?where - cell ?belt - belt)
    :precondition (and (at ?who ?where)
                       (adj ?where ?belt) 
                       (scanned ?what)
                       (holding ?who ?what)
    )
    :effect (and (on-belt ?what)
                 (not (holding ?who ?what))
                 (not (holding-pac ?who))
    )
)

)