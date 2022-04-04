(define (problem problem-ext-2)
    (:domain domain-ext)
    (:objects 
        c11 c12 c13 c14 c15 - cell
        c21 c22 c23 c24 c25 - cell
        c31 c32 c33 c34 c35 - cell
        c41 c42 c43 c44 c45 - cell
        c51 c52 c53 c54 c55 - cell

        the-mailbot - mailbot
        the-belt - belt 
        p001 - lightpack 
        p010 - lightpack 
        p011 - heavypack 
        the-scanner - scanner
        the-button - button 
        the-charger - charger 
        the-delbot - delbot 
    )
    
    (:init
        (adj c23 the-belt)
        (adj c35 the-belt) 
        (adj c15 the-belt)
        (adj c34 the-belt) 
        (adj c14 the-belt)

        (at p001 c51) 
        (at p010 c53) 
        (at p011 c55)
        
        (at the-button c35) 

        (at the-scanner c11)

        (at the-mailbot c33)
        (at the-delbot c15)

        (at the-charger c31)

        (= (battery-level the-mailbot) 10)
        (= (battery-level the-delbot) 10)

        (adj c51 c52)  (adj c52 c51)  
        (adj c52 c53)  (adj c53 c52)
        (adj c53 c54)  (adj c54 c53)
        (adj c54 c55)  (adj c55 c54)
        (adj c41 c42)  (adj c42 c41)
        (adj c42 c43)  (adj c43 c42)
        (adj c43 c44)  (adj c44 c43)
        (adj c44 c45)  (adj c45 c44)
        (adj c31 c32)  (adj c32 c31)
        (adj c32 c33)  (adj c33 c32)
        (adj c33 c34)  (adj c34 c33)
        (adj c34 c35)  (adj c35 c34)
        (adj c21 c22)  (adj c22 c21)
        (adj c22 c23)  (adj c23 c22)
        (adj c11 c12)  (adj c12 c11)
        (adj c13 c14)  (adj c14 c13)
        (adj c14 c15)  (adj c15 c14)
        (adj c51 c41)  (adj c41 c51)
        (adj c41 c31)  (adj c31 c41)
        (adj c21 c11)  (adj c11 c21)
        (adj c52 c42)  (adj c42 c52)
        (adj c42 c32)  (adj c32 c42)
        (adj c22 c12)  (adj c12 c22)
        (adj c53 c43)  (adj c43 c53)
        (adj c43 c33)  (adj c33 c43)
        (adj c33 c23)  (adj c23 c33)
        (adj c23 c13)  (adj c13 c23)
        (adj c54 c44)  (adj c44 c54)
        (adj c44 c34)  (adj c34 c44)
        (adj c55 c45)  (adj c45 c55)
        (adj c45 c35)  (adj c35 c45)
    )
    (:goal (and
        (on-belt p011)
        (scanned p011)
        (switch-on Button)
    ))
)
