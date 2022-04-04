(define (problem problem-ext-2)
    (:domain domain-ext)
    (:objects 
        C11 - cell
        C12 - cell
        C13 - cell
        C14 - cell
        C15 - cell

        C21 - cell
        C22 - cell
        C23 - cell
        C24 - cell
        C25 - cell

        C31 - cell
        C32 - cell
        C33 - cell
        C34 - cell
        C35 - cell

        C41 - cell
        C42 - cell
        C43 - cell
        C44 - cell
        C45 - cell

        C51 - cell
        C52 - cell
        C53 - cell
        C54 - cell
        C55 - cell

        MailBot - mailbot
        Belt - belt 
        p001 - lightpack 
        p010 - lightpack 
        p011 - heavypack 
        Scanner - scanner
        Button - button 
        PowerStn - charger 
        DeliveryBot - delbot 
               
    )
    
    (:init
        (adj C23 Belt)
        (adj C35 Belt) 
        (adj C15 Belt)
        (adj C34 Belt) 
        (adj C14 Belt)

        (at p001 C51) 
        (at p010 C53) 
        (at p011 C55)
        
        (at Button C35) 

        (at Scanner C11)

        (at MailBot C33)
        (at DeliveryBot C15)

        (at PowerStn C31)

        (= (battery-level MailBot) 10)
        (= (battery-level DeliveryBot) 10)

        (adj C51 C52)  (adj C52 C51)  
        (adj C52 C53)  (adj C53 C52)
        (adj C53 C54)  (adj C54 C53)
        (adj C54 C55)  (adj C55 C54)
        (adj C41 C42)  (adj C42 C41)
        (adj C42 C43)  (adj C43 C42)
        (adj C43 C44)  (adj C44 C43)
        (adj C44 C45)  (adj C45 C44)
        (adj C31 C32)  (adj C32 C31)
        (adj C32 C33)  (adj C33 C32)
        (adj C33 C34)  (adj C34 C33)
        (adj C34 C35)  (adj C35 C34)
        (adj C21 C22)  (adj C22 C21)
        (adj C22 C23)  (adj C23 C22)
        (adj C11 C12)  (adj C12 C11)
        (adj C13 C14)  (adj C14 C13)
        (adj C14 C15)  (adj C15 C14)
        (adj C51 C41)  (adj C41 C51)
        (adj C41 C31)  (adj C31 C41)
        (adj C21 C11)  (adj C11 C21)
        (adj C52 C42)  (adj C42 C52)
        (adj C42 C32)  (adj C32 C42)
        (adj C22 C12)  (adj C12 C22)
        (adj C53 C43)  (adj C43 C53)
        (adj C43 C33)  (adj C33 C43)
        (adj C33 C23)  (adj C23 C33)
        (adj C23 C13)  (adj C13 C23)
        (adj C54 C44)  (adj C44 C54)
        (adj C44 C34)  (adj C34 C44)
        (adj C55 C45)  (adj C45 C55)
        (adj C45 C35)  (adj C35 C45)

    )
    (:goal (and
        (on-belt p011)
        (scanned p011)
        (switch-on Button)
    ))
)
