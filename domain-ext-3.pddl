(define (domain domain-ext-3)

    (:requirements :adl :fluents)
    (:types bot package scanner button charger area - object
        mailbot - bot
        delbot - bot
        cell - area
        belt - area
        lightpack - package
        heavypack - package
    ) 
    
    (:predicates 
        (adj ?cell1 - area ?cell2 - area)
        (scanned ?package - package)
        (switch-on ?what - button)
        (bot-holding ?who - bot ?what - object)
        (at ?what - object ?where - cell)
        (holding ?who - bot)
        (on-belt ?package - package)
    )
    (:functions
        (battery-level ?what - object)
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

    ; (:action recharge-scanner
    ;     :parameters (?who - bot ?where - cell ?scanner - scanner ?how - charger)
    ;     :precondition (and 
    ;         (at ?who ?where)
    ;         (at ?how ?where)
    ;         (bot-holding ?who ?scanner)
    ;     )
    ;     :effect (and 
    ;         (assign (battery-level ?scanner) 2)
    ;     )
    ; )
    

    (:action move-not-holding 
        :parameters (?who - bot ?from - cell ?to - cell)
        :precondition (and
            (at ?who ?from)
            (adj ?from ?to)
            (>= (battery-level ?who) 1)
            (not (holding ?who))
        )
        :effect (and 
            (not(at ?who ?from))
            (at ?who ?to)
            (decrease (battery-level ?who) 1)
        )
        )

    (:action move-holding
        :parameters (?who - bot ?from - cell ?to - cell)
        :precondition (and 
            (at ?who ?from)
            (adj ?from ?to)
            (>= (battery-level ?who) 2)
            (holding ?who)
        )
        :effect (and 
            (not(at ?who ?from))
            (at ?who ?to)
            (decrease (battery-level ?who) 2)
        )
    )
    
    (:action move-with-heavypack
        :parameters (?mb - mailbot ?db - delbot ?from - cell ?to - cell ?what - heavypack)
        :precondition (and 
            (at ?mb ?from)
            (at ?db ?from)
            (adj ?from ?to)
            (>= (battery-level ?mb) 2)
            (>= (battery-level ?db) 2)
            (bot-holding ?mb ?what)
            (bot-holding ?db ?what)
        )
        :effect (and 
            (not (at ?mb ?from))
            (at ?mb ?to)
            (decrease (battery-level ?mb) 2)
            (not (at ?db ?from))
            (at ?db ?to)
            (decrease (battery-level ?db) 2)
        )
    )

    (:action pick-scanner 
        :parameters (?who - bot ?what - scanner ?where - cell)
        :precondition (and
            (at ?who ?where)
            (at ?what ?where)
            (not (holding ?who)) 
            (>= (battery-level ?who) 0.5)
        )

        :effect (and 
            (not (at ?what ?where))
            (bot-holding ?who ?what)
            (holding ?who)
            (decrease (battery-level ?who) 0.5)
        )
    )

    (:action pick-lightpack 
        :parameters (?who - bot ?what - lightpack ?where - cell)
        :precondition (and 
            (at ?who ?where)
            (at ?what ?where)
            (not (holding ?who))
            (>= (battery-level ?who) 0.5)
        )
        :effect (and 
            (not(at ?what ?where))
            (bot-holding ?who ?what)
            (holding ?who)
            (decrease (battery-level ?who) 0.5)
        )
    )

    (:action pick-heavypack
        :parameters (?mb - mailbot ?db - delbot ?what - heavypack ?where - cell)
        :precondition (and 
            (at ?mb ?where)
            (at ?db ?where)
            (at ?what ?where)
            (not (holding ?mb))
            (not (holding ?db))
            (>= (battery-level ?mb) 0.5)
            (>= (battery-level ?db) 0.5)
        )
        :effect (and 
            (not (at ?what ?where))
            (bot-holding ?mb ?what)
            (bot-holding ?db ?what)
            (holding ?mb)
            (holding ?db)
            (decrease (battery-level ?mb) 0.5)
            (decrease (battery-level ?db) 0.5)
        )
    )

    (:action drop-lightpack 
        :parameters (?who - bot ?what - lightpack ?where - cell)
        :precondition (and
            (at ?who ?where)
            (bot-holding ?who ?what)
            (>= (battery-level ?who) 0.2)
        )
        :effect (and 
            (at ?what ?where)
            (not (bot-holding ?who ?what))
            (not (holding ?who))
            (decrease (battery-level ?who) 0.2)
        )
    )

    (:action drop-scanner 
        :parameters (?who - bot ?what - scanner ?where - cell)
        :precondition (and
            (at ?who ?where)
            (bot-holding ?who ?what)
            (>= (battery-level ?who) 0.2)
        )
        :effect (and 
            (at ?what ?where)
            (not (bot-holding ?who ?what))
            (not (holding ?who))
            (decrease (battery-level ?who) 0.2)
        )
    )

    (:action drop-heavypack 
        :parameters (?mb - mailbot ?db - delbot ?what - heavypack ?where - cell)
        :precondition (and
            (at ?mb ?where)
            (at ?db ?where)
            (bot-holding ?mb ?what)
            (bot-holding ?db ?what)
            (>= (battery-level ?mb) 0.2)
            (>= (battery-level ?db) 0.2)
        )
        :effect (and 
            (at ?what ?where)
            (not (bot-holding ?mb ?what))
            (not (bot-holding ?db ?what))
            (not (holding ?mb))
            (not (holding ?mb))
            (decrease (battery-level ?mb) 0.2)
            (decrease (battery-level ?db) 0.2)
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

    (:action switch-belt-off
        :parameters (?who - bot ?what - button ?where - cell)
        :precondition (and 
            (switch-on ?what)
            (at ?what ?where)
            (at ?who ?where)
        )
        :effect (and 
            (not (switch-on ?what))
        )
    )
    

    (:action scan-pack 
        :parameters (?who - mailbot ?what - package ?how - scanner ?where - cell)
        :precondition (and 
            (not (scanned ?what))
            (at ?what ?where)
            (at ?who ?where)
            (bot-holding ?who ?how)
            ; (>= (battery-level ?how) 0.5)
        )
        :effect (and 
            (scanned ?what)
            ; (decrease (battery-level ?how) 0.5)
        )
    )
    (:action place-lightpack-on-belt 
        :parameters (?who - bot ?what - lightpack ?belt - belt ?where - cell ?button - button)
        :precondition (and 
            (bot-holding ?who ?what)
            (at ?who ?where)
            (adj ?where ?belt)
            (scanned ?what)
            (not (on-belt ?what))
            (>= (battery-level ?who) 0.2)
            (switch-on ?button)
        )
        :effect (and 
            (not(bot-holding ?who ?what))
            (not(holding ?who))
            (on-belt ?what)
            (decrease (battery-level ?who) 0.2)
        )
    )

    (:action place-heavypack-on-belt 
        :parameters (?mb - mailbot ?db - delbot ?what - heavypack ?belt - belt ?where - cell ?button - button)
        :precondition (and 
            (bot-holding ?mb ?what)
            (bot-holding ?db ?what)
            (at ?mb ?where)
            (at ?db ?where)
            (adj ?where ?belt)
            (scanned ?what)
            (not (on-belt ?what))
            (>= (battery-level ?mb) 0.2)
            (>= (battery-level ?db) 0.2)
            (switch-on ?button)
        )
        :effect (and 
            (not (bot-holding ?mb ?what))
            (not (bot-holding ?db ?what))
            (not (holding ?mb))
            (not (holding ?db))
            (on-belt ?what)
            (decrease (battery-level ?mb) 0.2)
            (decrease (battery-level ?db) 0.2)
        )
    )

)
