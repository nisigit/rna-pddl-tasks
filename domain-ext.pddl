(define (domain domain-ext)

    (:requirements :adl :fluents)

    (:types cell button belt bot charger pickable - object
        scanner - pickable
        package - pickable
        smallpac - package
        largepac - package
        mailbot - bot
        delbot - bot
    )

    (:predicates
        (at ?p1 ?p2)
        (adj ?cell1 - cell ?cell2)    
        (switch-on ?button - button)
        (scanned ?package - package)
        (holding ?who - bot)
        (bot-holding ?who - bot ?what - object) 
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

; Move either bot
(:action move-bot-holding
    :parameters (?who - bot ?from - cell ?to - cell)
    :precondition (and (at ?who ?from)
                       (adj ?from ?to)                
                       (holding ?who)
                       (>= (battery-level ?who) 2)
    )
    :effect (and (at ?who ?to)
                 (not (at ?who ?from))
                 (decrease (battery-level ?who) 2)
    )
)

(:action move-bot-not-holding
    :parameters (?who - bot ?from - cell ?to - cell)
    :precondition (and (at ?who ?from)
                       (adj ?from ?to)
                       (not (holding ?who))
                       (>= (battery-level ?who) 1)
    )
    :effect (and (at ?who ?to)
                 (not (at ?who ?from))
                 (decrease (battery-level ?who) 1)
    )
)

(:action move-bots-holding
    :parameters (?mb - mailbot ?db - delbot ?what - largepac ?from - cell ?to - cell)
    :precondition (and (at ?mb ?from)
                       (at ?db ?from)
                       (adj ?from ?to)
                       (bot-holding ?mb ?what)
                       (bot-holding ?db ?what)
                       (>= (battery-level ?mb) 2)
                       (>= (battery-level ?db) 2)
    )
    :effect (and (at ?mb ?to)
                 (at ?db ?to)
                 (not (at ?mb ?from))
                 (not (at ?db ?from))
                 (decrease (battery-level ?mb) 2)
                 (decrease (battery-level ?db) 2)
    )
)


(:action pick-small-pack
    :parameters (?who - bot ?what - smallpac ?where - cell)
    :precondition (and (at ?what ?where)
                       (at ?who ?where)
                       (not (holding ?who))
    )
    :effect (and (holding ?who)
                 (not (at ?what ?where))
                 (bot-holding ?who ?what)
    )
)


(:action pick-large-pack
    :parameters (?mb - mailbot ?db - delbot ?what - largepac ?where - cell)
    :precondition (and (at ?what ?where)
                       (at ?mb ?where)
                       (at ?db ?where)
                       (not (holding ?mb))
                       (not (holding ?db))
    )
    :effect (and (holding ?mb)
                 (holding ?db)
                 (not (at ?db ?where))
                 (bot-holding ?mb ?what)
                 (bot-holding ?mb ?what)
    ) 
)

(:action drop-small-pack
    :parameters (?who - bot ?what - smallpac ?where - cell)
    :precondition (and (at ?who ?where)
                       (bot-holding ?who ?what)
    )
    :effect (and (at ?what ?where)
                 (not (holding ?who))
                 (not (bot-holding ?who ?what))
    )
)

(:action drop-large-pack
    :parameters (?mb - mailbot ?db - delbot ?what - largepac ?where - cell)
    :precondition (and (at ?mb ?where)
                       (at ?db ?where)
                       (bot-holding ?mb ?what)
                       (bot-holding ?db ?what)
    )
    :effect (and (at ?what ?where)
                 (not (bot-holding ?mb ?what))
                 (not (bot-holding ?db ?what))
                 (not (holding ?mb))
                 (not (holding ?db))
    )
)

;; Scanner actions
(:action pick-scanner
    :parameters (?who - bot ?what - scanner ?where - cell)
    :precondition (and (at ?who ?where)
                       (at ?what ?where)
                       (not (holding ?who))
    )
    :effect (and (bot-holding ?who ?what)
                 (holding ?who)
                 (not (at ?what ?where))
    )
)

(:action drop-scanner
    :parameters (?who - bot ?what - scanner ?where - cell)
    :precondition (and (at ?who ?where)
                       (bot-holding ?who ?what)
    )
    :effect (and (at ?what ?where)
                 (not (bot-holding ?who ?what))
                 (not (holding ?who))
    )
)


(:action scan
    :parameters (?who - mailbot ?what - package ?where - cell ?scanner - scanner)
    :precondition (and (at ?who ?where)
                       (at ?what ?where)
                       (bot-holding ?who ?scanner)
                       (not (scanned ?what))
    )
    :effect (and (scanned ?what))
)
    
    
(:action switch-belt-on
    :parameters (?who - bot ?where - cell ?button - button)
    :precondition (and (not (switch-on ?button))
                       (at ?who ?where)
                       (at ?button ?where))
    :effect (and (switch-on ?button))
)

(:action place-small-pack-on-belt
    :parameters (?who - bot ?what - smallpac ?where - cell ?belt - belt)
    :precondition (and (at ?who ?where)
                       (adj ?where ?belt)
                       (scanned ?what)
                       (bot-holding ?who ?what)
    )
    :effect (and (on-belt ?what)
                 (not (holding ?who))
                 (not (bot-holding ?who ?what))
    )
)

(:action place-large-pack-on-belt
    :parameters (?mb - mailbot ?db - delbot ?what - smallpac ?where - cell ?belt - belt)
    :precondition (and (at ?mb ?where)
                       (at ?db ?where)
                       (adj ?where ?belt)
                       (scanned ?what)
                       (bot-holding ?mb ?what)
                       (bot-holding ?db ?what)
    )
    :effect (and (on-belt ?what)
                 (not (holding ?mb))
                 (not (holding ?db))
                 (not (bot-holding ?mb ?what))
                 (not (bot-holding ?db ?what))
    )
)


)