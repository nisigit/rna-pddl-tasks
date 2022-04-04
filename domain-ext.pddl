(define (domain domain-ext)

    (:requirements :adl :fluents)
    (:types bot belt package scanner button cell charger - object
        mailbot - bot
        delbot - bot
        lightpack - package
        heavypack - package
    ) 
    
    (:predicates 
        (adj ?cell1 - cell ?cell2 - object)
        (scanned ?package - package)
        (switch-on ?what - button)
        (bot-holding ?who - bot ?what - object)
        (at ?what - object ?where - cell)
        (holding ?who - bot)
        (on-belt ?package - package)
    )
    (:functions
        (battery-level ?bot - bot)
    )

    (:action move-not-holding 
        :parameters (?who - bot ?from - cell ?to - cell)
        :precondition (and 
            (not (holding ?who))
            (>= (battery-level ?who) 1)
            (at ?who ?from)
            (adj ?from ?to)
        )
        :effect (and 
            (not(at ?who ?from))
            (at ?who ?to)
            (decrease (battery-level ?who) 1)
        ))
    (:action move-holding
        :parameters (?who - bot ?from - cell ?to - cell)
        :precondition (and 
            (holding ?who)
            (>= (battery-level ?who) 2)
            (at ?who ?from)
            (adj ?from ?to)
        )
        :effect (and 
            (not(at ?who ?from))
            (at ?who ?to)
            (decrease (battery-level ?who) 2)
        ))
       (:action move-with-heavypack
        :parameters (?mb - mailbot ?db - delbot ?from - cell ?to - cell ?what - heavypack)
        :precondition (and 
            (bot-holding ?mb ?what)
            (bot-holding ?db ?what)
            (>= (battery-level ?mb) 2)
            (>= (battery-level ?db) 2)
            (at ?mb ?from)
            (at ?db ?from)
            (adj ?from ?to)
        )
        :effect (and 
            (not (at ?mb ?from))
            (at ?mb ?to)
            (decrease (battery-level ?mb) 2)
            (not (at ?db ?from))
            (at ?db ?to)
            (decrease (battery-level ?db) 2)
        ))

    (:action pick-scanner 
        :parameters (?who - bot ?what - scanner ?where - cell)
        :precondition (and
            (at ?who ?where)
            (at ?what ?where)
            (not (holding ?who)) 
        )

        :effect (and 
            (not(at ?what ?where))
            (bot-holding ?who ?what)
            (holding ?who)
        )
    )

    (:action pick-lightpack 
        :parameters (?who - bot ?what - lightpack ?where - cell)
        :precondition (and 
            (at ?who ?where)
            (at ?what ?where)
            (not (holding ?who))
        )
        :effect (and 
            (not(at ?what ?where))
            (bot-holding ?who ?what)
            (holding ?who)
        )
    )

    (:action pick-heavypack
        :parameters (?mb - mailbot ?db - delbot ?what - heavypack ?where - cell)
        :precondition (and 
            (not (holding ?mb))
            (not (holding ?db))
            (not (bot-holding ?mb ?what))
            (not (bot-holding ?db ?what))
            (at ?mb ?where)
            (at ?db ?where)
            (at ?what ?where)
        )
        :effect (and 
            (not (at ?what ?where))
            (bot-holding ?mb ?what)
            (bot-holding ?db ?what)
            (holding ?mb)
            (holding ?db)
        )
    )

    (:action drop-lightpack 
        :parameters (?who - bot ?what - lightpack ?where - cell)
        :precondition (and
            (at ?who ?where)
            (bot-holding ?who ?what)
        )
        :effect (and 
            (at ?what ?where)
            (not (bot-holding ?who ?what))
            (not (holding ?who))
        )
    )

    (:action drop-scanner 
        :parameters (?who - bot ?what - scanner ?where - cell)
        :precondition (and
            (at ?who ?where)
            (bot-holding ?who ?what)
        )
        :effect (and 
            (at ?what ?where)
            (not(bot-holding ?who ?what))
            (not(holding ?who))
        )
    )

    (:action drop-heavypack 
        :parameters (?mb - mailbot ?db - delbot ?what - heavypack ?where - cell)
        :precondition (and
            (at ?mb ?where)
            (at ?db ?where)
            (bot-holding ?mb ?what)
            (bot-holding ?db ?what)
        )
        :effect (and 
            (at ?what ?where)
            (not (bot-holding ?mb ?what))
            (not (bot-holding ?db ?what))
            (not (holding ?mb))
            (not (holding ?mb))
        )
    )


    (:action switch-belt-on 
        :parameters (?who - bot ?what - button ?where - cell)
        :precondition (and 
            (not (switch-on ?what))
            (at ?what ?where)
            (at ?who ?where)
         )
        :effect (and 
            (switch-on ?what)
        )
    )

    (:action scan-pack 
        :parameters (?who - mailbot ?what - package ?how - scanner ?where - cell)
        :precondition (and 
            (not (scanned ?what))
            (at ?what ?where)
            (at ?who ?where)
            (bot-holding ?who ?how)        
        )
        :effect (and 
            (scanned ?what)
        )
    )
    (:action place-lightpack-on-belt 
        :parameters (?who - bot ?what - lightpack ?belt - belt ?where - cell)
        :precondition (and 
            (bot-holding ?who ?what)
            (at ?who ?where)
            (adj ?where ?belt)
            (scanned ?what)
            (not (on-belt ?what))
        )
        :effect (and 
            (not(bot-holding ?who ?what))
            (not(holding ?who))
            (on-belt ?what)
        )
    )

    (:action place-heavypack-on-belt 
        :parameters (?mb - mailbot ?db - delbot ?what - heavypack ?belt - belt ?where - cell)
        :precondition (and 
            (bot-holding ?mb ?what)
            (bot-holding ?db ?what)
            (at ?mb ?where)
            (at ?db ?where)
            (adj ?where ?belt)
            (scanned ?what)
            (not (on-belt ?what))
        )
        :effect (and 
            (not (bot-holding ?mb ?what))
            (not (bot-holding ?db ?what))
            (not (holding ?mb))
            (not (holding ?db))
            (on-belt ?what)
        )
    )

    (:action recharge
        :parameters (?who - bot ?where - cell ?how - charger)
        :precondition (and 
            (at ?who ?where)
            (at ?how ?where)
        )
        :effect (and
            (assign (battery-level ?who) 15)
         )
    )
)

