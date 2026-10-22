;COA Food Ordering System final version

include irvine32.inc

.data
; --- Main Menu Text ---
    sys_title    BYTE "  =================================================================", 13, 10
                 BYTE "     .  .         _____ _   _  ___  _____ _   __          .  .   ", 13, 10
                 BYTE "      \/         /  ___| \ | |/ _ \/  __ \ | / /           \/    ", 13, 10
                 BYTE "     _MM_        \ `--.|  \| / /_\ \ /  \/ |/ /           _MM_   ", 13, 10
                 BYTE "    (o  o)        `--. \ . ` |  _  | |   |    \          (o  o)  ", 13, 10
                 BYTE "    /|^^|\       /\__/ / |\  | | | | \__/\ |\  \         /|^^|\  ", 13, 10
                 BYTE "     /  \        \____/\_| \_/\_| |_/\____/\_| \_/        /  \   ", 13, 10
                 BYTE "                                                                 ", 13, 10
                 BYTE "               [+::]  B O A R D   G A M E   C A F E  [+::]       ", 13, 10
                 BYTE "  =================================================================", 13, 10, 0
                 
    menu_opt    BYTE "1. Login or Register", 13, 10
                BYTE "2. Order Without Login", 13, 10
                BYTE "3. Exit Kiosk", 13, 10, 0
    
    prompt       BYTE "Tap your choice (1-3): ", 0
    error_msg    BYTE "Invalid input. Please try again.", 13, 10, 0





; --- Customer Login / Registration Text ---
    CLR_title   BYTE "=====================================", 13, 10
                BYTE "  CUSTOMER LOGIN / REGISTRATION   ", 13, 10
                BYTE "=====================================", 13, 10, 0

    CLR_opt     BYTE "1. Login", 13, 10
                BYTE "2. Registration", 13, 10
                 BYTE "3. Return", 13, 10, 0

    CLR_prompt  BYTE "Tap your choice (1-3): ", 0


  


; --- Room Booking Text ---
    RB_title   BYTE "  ===============================================", 13, 10
               BYTE "  ||                                           ||", 13, 10
               BYTE "  ||           R O O M   B O O K I N G         ||", 13, 10
               BYTE "  ||                                           ||", 13, 10
               BYTE "  ===============================================", 13, 10, 0

    RB_opt     BYTE "1. Small Room - RM15 per hour ( 2 - 4 players)", 13, 10
                BYTE "2. Standard Room - RM25 per hour ( 4 - 6 players)", 13, 10
                 BYTE "3. Large Room - RM40 per hour ( 8+ players)", 13, 10
                 BYTE "4. Return To Main Menu", 13, 10, 0

    RB_prompt  BYTE "Tap your choice (1-4): ", 0

    RB_hour     BYTE "Type In How Much Hours To Book: ", 0
    RB_hour_err BYTE "--> ERROR: Hours must be between 1 and 12. Try again.", 13, 10, 0


; --- Food Category Text ---
    FC_title   BYTE "  ===============================================", 13, 10
               BYTE "  ||                                           ||", 13, 10
               BYTE "  ||       F O O D   &   B E V E R A G E S     ||", 13, 10
               BYTE "  ||                                           ||", 13, 10
               BYTE "  ===============================================", 13, 10, 0

    FC_opt     BYTE "1. Snacks", 13, 10
               BYTE "2. Drinks", 13, 10
               BYTE "3. Main Courses", 13, 10
               BYTE "4. Combo Meals", 13, 10
               BYTE "5. Desserts", 13, 10
               BYTE "6. Finish Ordering & View Receipt", 13, 10, 0

    FC_prompt  BYTE "Select a category (1-6): ", 0
    
    ; Placeholder messages for when we build the sub-menus
    msg_snacks BYTE "--> Loading Snacks Menu...", 13, 10, 0
    msg_drinks BYTE "--> Loading Drinks Menu...", 13, 10, 0
    msg_mains  BYTE "--> Loading Main Courses Menu...", 13, 10, 0
    msg_combo  BYTE "--> Loading Combo Meals Menu...", 13, 10, 0
    msg_dess   BYTE "--> Loading Desserts Menu...", 13, 10, 0




; --- SHOPPING CART SYSTEM ---
    ; Room Prices (RM)
    SMALL_RATE EQU 15
    STD_RATE   EQU 25
    LARGE_RATE EQU 40

    ; The Cart Trackers
    cart_room_price DWORD 0          ; Saves the cost of the room
    cart_room_hours DWORD 0          ; Saves the amount of hours booked
    cart_room_name  BYTE 50 DUP(0)   ; Saves the NAME of the room for the receipt
    
    ; Room Name Strings (To copy into the cart)
    name_small BYTE "Small Room (2-4 pax)", 0
    name_std   BYTE "Standard Room (4-6 pax)", 0
    name_large BYTE "Large Room (8+ pax)", 0


    
   ; --- Food Cart Tracker ---
    cart_food_total DWORD 0          ; Saves the total cost of ALL food ordered




    ; --- Item Quantities (For the Receipt!) ---
    qty_snack1 DWORD 0               
    qty_snack2 DWORD 0               
    qty_snack3 DWORD 0               

    ; --- Snacks Menu Data ---
    SNACK1_RATE EQU 8
    SNACK2_RATE EQU 12
    SNACK3_RATE EQU 15

    sm_title BYTE "=====================================", 13, 10
             BYTE "             SNACKS MENU             ", 13, 10
             BYTE "=====================================", 13, 10, 0

    sm_opt   BYTE "1. French Fries - RM 8", 13, 10
             BYTE "2. Nachos & Cheese - RM 12", 13, 10
             BYTE "3. Board Game Snack Platter - RM 15", 13, 10
             BYTE "4. Return to Food Categories", 13, 10, 0

    sm_prompt BYTE "Select a snack to add (1-4): ", 0
    msg_added BYTE "--> Item added to cart! Current Food Total: RM ", 0


    ; --- Drinks Menu Data ---
    ; --- Item Quantities (For the Receipt) ---
    qty_drink1 DWORD 0               
    qty_drink2 DWORD 0               
    qty_drink3 DWORD 0               

    ; --- Item Price ---
    DRINK1_RATE EQU 4
    DRINK2_RATE EQU 6
    DRINK3_RATE EQU 8

    dm_title BYTE "=====================================", 13, 10
             BYTE "             DRINKS MENU             ", 13, 10
             BYTE "=====================================", 13, 10, 0

    dm_opt   BYTE "1. Coca-Cola - RM 4", 13, 10
             BYTE "2. Watermelon Juice - RM 6", 13, 10
             BYTE "3. Matcha Green Tea Latte - RM 8", 13, 10
             BYTE "4. Return to Food Categories", 13, 10, 0

    dm_prompt BYTE "Select a drinks to add (1-4): ", 0



    ; --- Main Courses Menu Data ---
    qty_main1 DWORD 0
    qty_main2 DWORD 0
    qty_main3 DWORD 0

    MAIN1_RATE EQU 18
    MAIN2_RATE EQU 16
    MAIN3_RATE EQU 12

    mc_title BYTE "=====================================", 13, 10
             BYTE "          MAIN COURSES MENU          ", 13, 10
             BYTE "=====================================", 13, 10, 0

    mc_opt   BYTE "1. Classic Chicken Chop - RM 18", 13, 10
             BYTE "2. Spaghetti Bolognese - RM 16", 13, 10
             BYTE "3. Signature Nasi Lemak - RM 12", 13, 10
             BYTE "4. Return to Food Categories", 13, 10, 0

    mc_prompt BYTE "Select a main course to add (1-4): ", 0

    ; --- Combo Meals Menu Data ---
    qty_combo1 DWORD 0
    qty_combo2 DWORD 0
    qty_combo3 DWORD 0

    COMBO1_RATE EQU 35
    COMBO2_RATE EQU 65
    COMBO3_RATE EQU 120

    cb_title BYTE "=====================================", 13, 10
             BYTE "           COMBO MEALS MENU          ", 13, 10
             BYTE "=====================================", 13, 10, 0

    cb_opt   BYTE "1. Couple Combo (2 Pax) - RM 35", 13, 10
             BYTE "2. Party Combo (4 Pax) - RM 65", 13, 10
             BYTE "3. Ultimate Gamer Combo (8 Pax) - RM 120", 13, 10
             BYTE "4. Return to Food Categories", 13, 10, 0

    cb_prompt BYTE "Select a combo meal to add (1-4): ", 0

    ; --- Desserts Menu Data ---
    qty_dessert1 DWORD 0
    qty_dessert2 DWORD 0
    qty_dessert3 DWORD 0

    DESSERT1_RATE EQU 10
    DESSERT2_RATE EQU 6
    DESSERT3_RATE EQU 12

    ds_title BYTE "=====================================", 13, 10
             BYTE "            DESSERTS MENU            ", 13, 10
             BYTE "=====================================", 13, 10, 0

    ds_opt   BYTE "1. Warm Chocolate Brownie - RM 10", 13, 10
             BYTE "2. Vanilla Ice Cream Scoop - RM 6", 13, 10
             BYTE "3. Crispy Waffle with Syrup - RM 12", 13, 10
             BYTE "4. Return to Food Categories", 13, 10, 0

    ds_prompt BYTE "Select a dessert to add (1-4): ", 0





    ; =========================================
    ; --- RECEIPT & CHECKOUT DATA ---
    ; =========================================
    grand_total DWORD 0
    
    rcpt_title BYTE "=====================================", 13, 10
               BYTE "             YOUR RECEIPT            ", 13, 10
               BYTE "=====================================", 13, 10, 0
               
    str_room   BYTE "ROOM BOOKED: ", 0
    str_hours  BYTE "HOURS: ", 0
    str_food   BYTE "--- FOOD & BEVERAGES ---", 13, 10, 0
    str_total  BYTE "-------------------------------------", 13, 10
               BYTE "GRAND TOTAL: RM ", 0
               
    str_times  BYTE " x ", 0        ; Prints the "x" for quantities (e.g., French Fries x 2)


    ; =========================================
    ; --- PAYMENT GATEWAY DATA ---
    ; =========================================
    pmt_title   BYTE "=====================================", 13, 10
                BYTE "             PAYMENT                 ", 13, 10
                BYTE "=====================================", 13, 10, 0
                
    pmt_prompt  BYTE "Please insert cash amount (RM): ", 0
    pmt_err     BYTE "--> ERROR: Insufficient funds. Please insert enough cash!", 13, 10, 0
    pmt_change  BYTE "--> Payment Successful! Your change is: RM ", 0
    pmt_ty      BYTE "--> Thank you for visiting Snack & Board Game Cafe! Enjoy!", 13, 10, 0



    ; --- Food Name Strings for the Receipt ---
    n_s1 BYTE "French Fries", 0
    n_s2 BYTE "Nachos & Cheese", 0
    n_s3 BYTE "Board Game Snack Platter", 0
    
    ; --- Drinks Strings ---
    n_d1 BYTE "Coca-Cola", 0
    n_d2 BYTE "Watermelon Juice", 0
    n_d3 BYTE "Matcha Green Tea Latte", 0
    
    ; --- Main Course Strings ---
    n_m1 BYTE "Classic Chicken Chop", 0
    n_m2 BYTE "Spaghetti Bolognese", 0
    n_m3 BYTE "Signature Nasi Lemak", 0
    
    ; --- Combo Meal Strings ---
    n_c1 BYTE "Couple Combo (2 Pax)", 0
    n_c2 BYTE "Party Combo (4 Pax)", 0
    n_c3 BYTE "Ultimate Gamer Combo (8 Pax)", 0
    
    ; --- Dessert Strings ---
    n_ds1 BYTE "Warm Chocolate Brownie", 0
    n_ds2 BYTE "Vanilla Ice Cream Scoop", 0
    n_ds3 BYTE "Crispy Waffle with Syrup", 0


























; --- Customer Register Back System ---
    ; --- File System Variables ---
    start_points BYTE "100", 0   ; Default starting points as text!
    Cfilename    BYTE "customer.txt", 0
    CfileHandle  HANDLE ?            ; Windows will give us an ID number for the file
    
    ; --- Text Buffers (Empty arrays waiting for input) ---
    Cusername    BYTE 50 DUP(0)      ; DUP(0) creates 50 empty bytes (like char array[50])
    Cpassword    BYTE 50 DUP(0)      
    Cname_len    DWORD ?             ; To remember exactly how many letters they typed
    Cpass_len    DWORD ?
    
    ; --- The Cipher Key ---
    Csecret_key  BYTE "X"            ; Our XOR encryption key (can be any letter)
    
    ; --- User Prompts ---
    Creg_title      BYTE "=====================================", 13, 10
                    BYTE "         CUSTOMER REGISTRATION       ", 13, 10
                    BYTE "=====================================", 13, 10, 0

    prompt_user BYTE "Enter new username: ", 0
    prompt_pass BYTE "Enter new password: ", 0
    success_msg BYTE "Registration successful! Saved to database.", 13, 10, 0
    
    comma_str   BYTE ",", 0         ; To separate the name and password in the text file

    newline     BYTE 13, 10    ; Carriage return and line feed to separate users



; --- Customer Login Back System ---
    ; --- Login Buffers ---
    Clogin_user    BYTE 50 DUP(0)
    Clogin_pass    BYTE 50 DUP(0)
    Clogin_user_len DWORD ?
    Clogin_pass_len DWORD ?
    
    ; --- The Haystack (File Data) ---
    Cfile_buffer   BYTE 1024 DUP(0)  ; A giant array to hold up to 1024 characters from the file
    Cbytes_read    DWORD ?           ; How many characters we actually loaded
    
    ; --- System Messages ---
    prompt_l_user BYTE "Enter username: ", 0
    prompt_l_pass BYTE "Enter password: ", 0
    msg_success   BYTE "--> LOGIN SUCCESSFUL! Access Granted.", 13, 10, 0
    msg_fail      BYTE "--> LOGIN FAILED! Incorrect username or password.", 13, 10, 0
    msg_no_file   BYTE "--> ERROR: No accounts database found!", 13, 10, 0

    Csearch_target BYTE 100 DUP(0)   ; This will hold "username,password"
    last_match_ptr DWORD 0           ; <--- NEW: Tracks the newest entry at the bottom!



; --- Customer 'Logged In" State" ---
    pts_buffer BYTE 20 DUP(0)       ; Empty string to hold the converted points
    pts_len    DWORD ?              ; Length of the converted string
    current_user BYTE 50 DUP(0)  ; The safe box for the current logged in user's name , *you can retrieve the username from here*
    current_pts  DWORD 100       ; I will just hardcode 100 points for testing right now, *i think u nid to discuss with me so that the customer.txt file to save the file like"customername,customerpassword,pointremaining" so that it will save the remaining point
   
    ; --- Member Dashboard & Discount Variables ---
    is_member       DWORD 0      ; FLAG: 0 = Guest, 1 = Member
    discount_amount DWORD 0      ; How much money we are subtracting
    points_earned   DWORD 0      ; How many points they get for this order
    points_spent    DWORD 0      ; <--- NEW: Tracks points spent in case we need to refund them!
    
    md_title  BYTE "=====================================", 13, 10
              BYTE "           MEMBER DASHBOARD          ", 13, 10
              BYTE "=====================================", 13, 10, 0
              
    md_hi     BYTE "--> Hi, ", 0
    md_pts    BYTE "--> Current Point Balance: ", 0
    
    md_opt    BYTE "1. Start Ordering", 13, 10
              BYTE "2. Check Point Balance", 13, 10
              BYTE "3. Redeem Point", 13, 10
              BYTE "4. Logout", 13, 10, 0

    md_prompt BYTE "Tap your choice (1-4): ", 0
    
    ; --- Receipt Discount Strings ---
    str_sub   BYTE "SUBTOTAL: RM ", 0
    str_disc  BYTE "MEMBER DISCOUNT (10%): -RM ", 0
    str_earn  BYTE "POINTS EARNED THIS ORDER: +", 0
    

; --- Transition Messages (Placeholders for now) ---
    cust_msg     BYTE "--> Loading Customer Interface...", 13, 10, 0
    staff_msg    BYTE "--> Loading Staff Gateway...", 13, 10, 0
    payment_msg     BYTE "--> Loading Payment Gateway...", 13, 10, 0


    ; --- Point Redemption Data ---
    rp_title  BYTE "=====================================", 13, 10
              BYTE "           REDEEM POINTS             ", 13, 10
              BYTE "=====================================", 13, 10, 0
              
    rp_opt    BYTE "1. Free French Fries (Cost: 50 pts)", 13, 10
              BYTE "2. Free Coca-Cola (Cost: 30 pts)", 13, 10
              BYTE "3. Return to Dashboard", 13, 10, 0
              
    rp_prompt BYTE "Select an item to redeem (1-3): ", 0
    rp_err    BYTE "--> ERROR: Not enough points for this item!", 13, 10, 0
    rp_succ   BYTE "--> SUCCESS: Free item added to your cart!", 13, 10, 0






.code
    main    proc

;=============================================================== MAIN   MENU =======================================================================
; --- Main Menu Interface ---
MainMenu:
    call Clrscr                 
    
    ; --- Set Color to Cyan (11) for Title ---
    mov eax, 5                 ; 11 = Light Cyan foreground, Black background
    call SetTextColor
    
    mov edx, OFFSET sys_title
    call WriteString
    
    ; --- Set Color back to White (15) for Options ---
    mov eax, 8               ; 15 = White
    call SetTextColor
    
    mov edx, OFFSET menu_opt
    call WriteString
    call Crlf                   
    
   

    ; Get User Input
    mov edx, OFFSET prompt
    call WriteString            ; print prompt
    call ReadDec                ; store user input into EAX
    call Crlf
    
; --- Process User Input (If/Else) ---
    cmp eax, 1                  ; user pressed 1
    je CustomerLRPage             ; To Customer Page
    
    cmp eax, 2                  ; user pressed 2
    je RoomBooking                ; To RoomBooking
    
    cmp eax, 3                  ; user pressed 3
    je ExitKiosk                ; Close Program
    
    ; Validation Check
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg                ; Pauses and says "Press any key to continue..."
    jmp MainMenu             ; Loops back to the top to redraw the menu

; ==============================================================================================================================================================


;============================================================ 1. Customer =======================================================================
; --- Customer Login / Registration ---
CustomerLRPage:
    call Clrscr                                                 ; clear screen

    ; Print Interface
    mov edx, OFFSET CLR_title
    call WriteString
    mov edx, OFFSET CLR_opt
    call WriteString
    call Crlf                                                   ; leave a blank after option

    ; Get user input
    mov edx, OFFSET CLR_prompt
    call WriteString
    call ReadDec
    call Crlf

; --- Process User Input (If/Else) ---
    cmp eax, 1                  ; user pressed 1
    je CustomerLoginPage        ; To Login Page
    
    cmp eax, 2                  ; user pressed 2
    je CustomerRegisterPage     ; To Register Page
    
    cmp eax, 3                  ; user pressed 3
    je MainMenu                 ; Back to main

    ; Validation Check
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg                ; Irvine32: Pauses and says "Press any key to continue..."
    jmp CustomerLRPage             ; Loops back to the top to redraw the menu



; *** 1. Customer Login ***
CustomerLoginPage:
    call CLoginUser             ; Go run the login screen
    
    cmp eax, 1                  ; Did the login screen return a 1 (Success)?
    je MemberDashboard              ; If YES: Teleport to the Room Booking interface!
    
    jmp CustomerLRPage          ; If NO: Go back to the Login/Register options


; *** 2. Customer Registration ***
CustomerRegisterPage:
    call RegisterCust
    jmp CustomerLRPage             ; Send them back to the start screen when done


; ==============================================================================================================================================================

; ==============================================================================================================================================================
; MEMBER DASHBOARD
; ==============================================================================================================================================================
MemberDashboard:
    call Clrscr
    mov edx, OFFSET md_title
    call WriteString
    
    mov edx, OFFSET md_hi
    call WriteString
    mov edx, OFFSET current_user
    call WriteString
    call Crlf
    call Crlf
    
    mov edx, OFFSET md_opt
    call WriteString
    call Crlf
    
    mov edx, OFFSET md_prompt
    call WriteString
    call ReadDec
    call Crlf
    
    ; --- Routing ---
    cmp eax, 1
    je StartMemberOrder
    
    cmp eax, 2
    je ViewPoints
    
    cmp eax, 3
    je RedeemPointPage          
    
    cmp eax, 4
    je LogoutMember
    
    ; Error
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg
    jmp MemberDashboard

StartMemberOrder:
    mov is_member, 1            ; Set the flag to 1 so the system knows they get a discount
    jmp RoomBooking

ViewPoints:
    mov edx, OFFSET md_pts
    call WriteString
    mov eax, current_pts
    call WriteDec
    call Crlf
    call WaitMsg
    jmp MemberDashboard

LogoutMember:
    ; --- 1. Refund Unused Points ---
    mov eax, points_spent
    add current_pts, eax        
    
    ; --- 2. Let the Reset System Handle the Rest! ---
    ; ResetCartSystem already converts the points, saves the file, 
    ; and wipes the variables safely. We just jump straight to it!
    jmp ResetCartSystem
    jmp ResetCartSystem


    ; ==============================================================================================================================================================
; POINT REWARD SYSTEM
; ==============================================================================================================================================================
RedeemPointPage:
    call Clrscr
    mov edx, OFFSET rp_title
    call WriteString
    
    ; --- Show Current Points ---
    mov edx, OFFSET md_pts
    call WriteString
    mov eax, current_pts
    call WriteDec
    call Crlf
    call Crlf
    
    ; --- Print Options ---
    mov edx, OFFSET rp_opt
    call WriteString
    mov edx, OFFSET rp_prompt
    call WriteString
    call ReadDec
    call Crlf
    
    ; --- Routing ---
    cmp eax, 1
    je RedeemFries
    
    cmp eax, 2
    je RedeemCoke
    
    cmp eax, 3
    je MemberDashboard          ; Go back
    
    ; Error
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg
    jmp RedeemPointPage

; --- Redemption Logic ---
RedeemFries:
    cmp current_pts, 50         ; Do they have at least 50 points?
    jl NotEnoughPoints          ; If Less, jump to error!
    
    sub current_pts, 50         ; Deduct the points
    add points_spent, 50
    inc qty_snack1              ; Add the item to their cart! (But DO NOT add price to cart_food_total!)
    jmp RedeemSuccess

RedeemCoke:
    cmp current_pts, 30         ; Do they have at least 30 points?
    jl NotEnoughPoints
    
    sub current_pts, 30
    add points_spent, 30
    inc qty_drink1
    jmp RedeemSuccess

NotEnoughPoints:
    mov edx, OFFSET rp_err
    call WriteString
    call WaitMsg
    jmp RedeemPointPage

RedeemSuccess:
    mov edx, OFFSET rp_succ
    call WriteString
    call WaitMsg
    jmp RedeemPointPage


;================================================================ 1. ROOM BOOKING =======================================================================
RoomBooking:
    call Clrscr                                                 
    
    ; --- Set Color to Yellow (14) for the Rooms Header ---
    mov eax, 1                 
    call SetTextColor
    
    mov edx, OFFSET RB_title
    call WriteString
    
    ; --- Set Color back to White (15) for Options ---
    mov eax, 8
    call SetTextColor
    
    mov edx, OFFSET RB_opt
    call WriteString
    call Crlf                                                   

    ; Get user input
    mov edx, OFFSET RB_prompt
    call WriteString
    call ReadDec
    call Crlf

    ; --- Process User Input (If/Else) ---
    cmp eax, 1                  ; user pressed 1
    je SmallRSelected        ; Small Room Selected
    
    cmp eax, 2                  ; user pressed 2
    je StandardRSelected     ; Standard Room Selected
    
    cmp eax, 3                  ; user pressed 3
    je LargeRSelected                 ; Large Room Selected

    cmp eax, 4
    je BailOut                  ; <--- THE FIX: Send them to a safety checkpoint!

    ; Validation Check
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg                
    jmp RoomBooking             

; --- THE SAFETY CHECKPOINT ---
BailOut:
    cmp is_member, 1
    je LogoutMember             ; If Member: Refund points and save file!
    jmp ResetCartSystem         ; If Guest: Wipe the cart and reset!



; *** 1. Small Room ***
SmallRSelected:
    mov edx, OFFSET RB_hour
    call WriteString
    
    call ReadDec                                                ; User types the hours.
    
    ; =========================================
    ; --- THE VALIDATION ---
    ; =========================================
    cmp eax, 1                  ; Check if they typed 0 or negative
    jl InvalidSmallHour         ; JL: If Less than 1, jump to error
    
    cmp eax, 12                 ; Check if they typed 13 or more
    jg InvalidSmallHour         ; JG: If Greater than 12, jump to error

    ; =========================================
    ; --- IF IT PASSES, DO THE MATH ---
    ; =========================================
    mov cart_room_hours, eax                                    
    mov ebx, SMALL_RATE                                         
    mul ebx                                                     
    mov cart_room_price, eax                                    

    INVOKE Str_copy, ADDR name_small, ADDR cart_room_name       
    
    call WaitMsg                
    jmp FoodCategoryPage

InvalidSmallHour:
    mov edx, OFFSET RB_hour_err ; Load the error text
    call WriteString
    jmp SmallRSelected          ; Force them to try again!

; *** 2. Standard Room ***
StandardRSelected:
    mov edx, OFFSET RB_hour
    call WriteString
    
    call ReadDec    
    
    ; =========================================
    ; --- THE VALIDATION ---
    ; =========================================
    cmp eax, 1                  ; Check if they typed 0 or negative
    jl InvalidStdHour         ; JL: If Less than 1, jump to error
    
    cmp eax, 12                 ; Check if they typed 13 or more
    jg InvalidStdHour         ; JG: If Greater than 12, jump to error

    ; =========================================
    ; --- IF IT PASSES, DO THE MATH ---
    ; =========================================
    mov cart_room_hours, eax                                    
    mov ebx, STD_RATE                                         
    mul ebx                                                     
    mov cart_room_price, eax                                    

    INVOKE Str_copy, ADDR name_std, ADDR cart_room_name       
    
    call WaitMsg                
    jmp FoodCategoryPage

InvalidStdHour:
    mov edx, OFFSET RB_hour_err ; Load the error text
    call WriteString
    jmp SmallRSelected          ; Force them to try again!

           

; *** 3. Large Room ***
LargeRSelected:
    mov edx, OFFSET RB_hour
    call WriteString
    
    call ReadDec                  
     
    ; =========================================
    ; --- THE VALIDATION ---
    ; =========================================
    cmp eax, 1                  ; Check if they typed 0 or negative
    jl InvalidLargeHour         ; JL: If Less than 1, jump to error
    
    cmp eax, 12                 ; Check if they typed 13 or more
    jg InvalidLargeHour         ; JG: If Greater than 12, jump to error

    ; =========================================
    ; --- IF IT PASSES, DO THE MATH ---
    ; =========================================
    mov cart_room_hours, eax                                    
    mov ebx, LARGE_RATE                                         
    mul ebx                                                     
    mov cart_room_price, eax                                    

    INVOKE Str_copy, ADDR name_large, ADDR cart_room_name       
    
    call WaitMsg                
    jmp FoodCategoryPage

InvalidLargeHour:
    mov edx, OFFSET RB_hour_err ; Load the error text
    call WriteString
    jmp SmallRSelected          ; Force them to try again!



; ==============================================================================================================================================================


;================================================================ 5. FOOD CATEGORY =======================================================================
FoodCategoryPage:
    call Clrscr
    
    ; --- Set Color to Light Magenta (13) for the Food Header ---
    mov eax, 6
    call SetTextColor
    
    mov edx, OFFSET FC_title
    call WriteString
    
    ; --- Set Color back to White (15) for Options ---
    mov eax, 8
    call SetTextColor
    
    mov edx, OFFSET FC_opt
    call WriteString
    call Crlf
    
    ; --- 2. Get User Input ---
    mov edx, OFFSET FC_prompt
    call WriteString
    call ReadDec
    call Crlf
    
    ; --- 3. The Routing ---
    cmp eax, 1
    je SnacksMenu
    
    cmp eax, 2
    je DrinksMenu
    
    cmp eax, 3
    je MainCourseMenu
    
    cmp eax, 4
    je ComboMenu
    
    cmp eax, 5
    je DessertsMenu
    
    cmp eax, 6
    je CheckoutPage                 
    
    ; --- Error Handling ---
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg
    jmp FoodCategoryPage

; ---------------------------------------------------------
; FOOD SUB-MENU  
; ---------------------------------------------------------
; ---------------------------------------------------------
; 1. SNACKS MENU
; ---------------------------------------------------------
SnacksMenu:
    call Clrscr
    mov edx, OFFSET sm_title
    call WriteString
    mov edx, OFFSET sm_opt
    call WriteString
    call Crlf
    
    mov edx, OFFSET sm_prompt
    call WriteString
    call ReadDec                ; User picks a snack
    call Crlf
    
    ; Process User Input
    cmp eax, 1
    je AddSnack1
    
    cmp eax, 2
    je AddSnack2
    
    cmp eax, 3
    je AddSnack3
    
    cmp eax, 4
    je FoodCategoryPage         ; Send them back to the Hub
    
    ; --- Error Handling ---
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg
    jmp SnacksMenu

; --- Math & Cart Logic ---
AddSnack1:
    inc qty_snack1
    mov eax, cart_food_total    ; Get the current food total
    add eax, SNACK1_RATE        ; Add RM 8
    mov cart_food_total, eax    ; Save the new total back to the cart
    jmp SnackAddedMsg           ; Go print success

AddSnack2:
    inc qty_snack2
    mov eax, cart_food_total    
    add eax, SNACK2_RATE        ; Add RM 12
    mov cart_food_total, eax    
    jmp SnackAddedMsg

AddSnack3:
    inc qty_snack3
    mov eax, cart_food_total    
    add eax, SNACK3_RATE        ; Add RM 15
    mov cart_food_total, eax    
    jmp SnackAddedMsg

SnackAddedMsg:
    mov edx, OFFSET msg_added
    call WriteString
    mov eax, cart_food_total    ; Load the new total into EAX
    call WriteDec               ; Print the running total so the user sees it
    call Crlf
    call WaitMsg
    jmp SnacksMenu              ; Loop back so they can buy MORE snacks






; ---------------------------------------------------------
; 2. DRINKS MENU
; ---------------------------------------------------------
DrinksMenu:
    call Clrscr
    mov edx, OFFSET dm_title
    call WriteString
    mov edx, OFFSET dm_opt
    call WriteString
    call Crlf
    
    mov edx, OFFSET dm_prompt
    call WriteString
    call ReadDec                ; User picks a drinks
    call Crlf
    
    ; Process User Input
    cmp eax, 1
    je AddDrink1
    
    cmp eax, 2
    je AddDrink2
    
    cmp eax, 3
    je AddDrink3
    
    cmp eax, 4
    je FoodCategoryPage         ; Send them back to the Hub
    
    ; --- Error Handling ---
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg
    jmp DrinksMenu

; --- Math & Cart Logic ---
AddDrink1:
    inc qty_drink1
    mov eax, cart_food_total    ; Get the current food total
    add eax, DRINK1_RATE        ; 
    mov cart_food_total, eax    ; Save the new total back to the cart
    jmp DrinkAddedMsg           ; Go print success

AddDrink2:
    inc qty_drink2
    mov eax, cart_food_total    
    add eax, DRINK2_RATE       
    mov cart_food_total, eax    
    jmp DrinkAddedMsg

AddDrink3:
    inc qty_drink3
    mov eax, cart_food_total    
    add eax, DRINK3_RATE        
    mov cart_food_total, eax    
    jmp DrinkAddedMsg

DrinkAddedMsg:
    mov edx, OFFSET msg_added
    call WriteString
    mov eax, cart_food_total    ; Load the new total into EAX
    call WriteDec               ; Print the running total so the user sees it
    call Crlf
    call WaitMsg
    jmp DrinksMenu              ; Loop back so they can buy MORE



; ---------------------------------------------------------
; 3. MAIN COURSES MENU
; ---------------------------------------------------------
MainCourseMenu:
    call Clrscr
    mov edx, OFFSET mc_title
    call WriteString
    mov edx, OFFSET mc_opt
    call WriteString
    call Crlf
    
    mov edx, OFFSET mc_prompt
    call WriteString
    call ReadDec                
    call Crlf
    
    cmp eax, 1
    je AddMain1
    cmp eax, 2
    je AddMain2
    cmp eax, 3
    je AddMain3
    cmp eax, 4
    je FoodCategoryPage         
    
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg
    jmp MainCourseMenu

AddMain1:
    inc qty_main1
    mov eax, cart_food_total    
    add eax, MAIN1_RATE        
    mov cart_food_total, eax    
    jmp MainAddedMsg           

AddMain2:
    inc qty_main2
    mov eax, cart_food_total    
    add eax, MAIN2_RATE       
    mov cart_food_total, eax    
    jmp MainAddedMsg

AddMain3:
    inc qty_main3
    mov eax, cart_food_total    
    add eax, MAIN3_RATE        
    mov cart_food_total, eax    
    jmp MainAddedMsg

MainAddedMsg:
    mov edx, OFFSET msg_added
    call WriteString
    mov eax, cart_food_total    
    call WriteDec               
    call Crlf
    call WaitMsg
    jmp MainCourseMenu          

; ---------------------------------------------------------
; 4. COMBO MEALS MENU
; ---------------------------------------------------------
ComboMenu:
    call Clrscr
    mov edx, OFFSET cb_title
    call WriteString
    mov edx, OFFSET cb_opt
    call WriteString
    call Crlf
    
    mov edx, OFFSET cb_prompt
    call WriteString
    call ReadDec                
    call Crlf
    
    cmp eax, 1
    je AddCombo1
    cmp eax, 2
    je AddCombo2
    cmp eax, 3
    je AddCombo3
    cmp eax, 4
    je FoodCategoryPage         
    
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg
    jmp ComboMenu

AddCombo1:
    inc qty_combo1
    mov eax, cart_food_total    
    add eax, COMBO1_RATE        
    mov cart_food_total, eax    
    jmp ComboAddedMsg           

AddCombo2:
    inc qty_combo2
    mov eax, cart_food_total    
    add eax, COMBO2_RATE       
    mov cart_food_total, eax    
    jmp ComboAddedMsg

AddCombo3:
    inc qty_combo3
    mov eax, cart_food_total    
    add eax, COMBO3_RATE        
    mov cart_food_total, eax    
    jmp ComboAddedMsg

ComboAddedMsg:
    mov edx, OFFSET msg_added
    call WriteString
    mov eax, cart_food_total    
    call WriteDec               
    call Crlf
    call WaitMsg
    jmp ComboMenu          

; ---------------------------------------------------------
; 5. DESSERTS MENU
; ---------------------------------------------------------
DessertsMenu:
    call Clrscr
    mov edx, OFFSET ds_title
    call WriteString
    mov edx, OFFSET ds_opt
    call WriteString
    call Crlf
    
    mov edx, OFFSET ds_prompt
    call WriteString
    call ReadDec                
    call Crlf
    
    cmp eax, 1
    je AddDessert1
    cmp eax, 2
    je AddDessert2
    cmp eax, 3
    je AddDessert3
    cmp eax, 4
    je FoodCategoryPage         
    
    mov edx, OFFSET error_msg
    call WriteString
    call WaitMsg
    jmp DessertsMenu

AddDessert1:
    inc qty_dessert1
    mov eax, cart_food_total    
    add eax, DESSERT1_RATE        
    mov cart_food_total, eax    
    jmp DessertAddedMsg           

AddDessert2:
    inc qty_dessert2
    mov eax, cart_food_total    
    add eax, DESSERT2_RATE       
    mov cart_food_total, eax    
    jmp DessertAddedMsg

AddDessert3:
    inc qty_dessert3
    mov eax, cart_food_total    
    add eax, DESSERT3_RATE        
    mov cart_food_total, eax    
    jmp DessertAddedMsg

DessertAddedMsg:
    mov edx, OFFSET msg_added
    call WriteString
    mov eax, cart_food_total    
    call WriteDec               
    call Crlf
    call WaitMsg
    jmp DessertsMenu



    
; ====================================================================================================
; 6. CHECKOUT & RECEIPT PAGE
; ====================================================================================================
CheckoutPage:
    call Clrscr
    
    ; --- 1. CALCULATE SUBTOTAL ---
    mov eax, cart_room_price
    add eax, cart_food_total
    mov grand_total, eax
    mov discount_amount, 0      ; Default to 0 discount for guests
    mov points_earned, 0        ; Default to 0 points for guests
    
    ; --- 1.5 APPLY MEMBER DISCOUNT & POINTS ---
    cmp is_member, 1            ; Are they logged in?
    jne PrintReceiptHeader      ; If NO, skip the math and print the receipt normally
    
    ; If YES: Calculate 10% (grand_total / 10)
    mov edx, 0                  ; Always put 0 in EDX before dividing
    mov eax, grand_total
    mov ebx, 10
    div ebx                     ; EAX now holds the 10% amount!
    
    mov discount_amount, eax    ; Save the discount
    mov points_earned, eax      ; Save the points earned (RM100 = 10 pts)
    
    ; Apply the discount to the bill
    mov eax, grand_total
    sub eax, discount_amount
    mov grand_total, eax        ; Overwrite the grand total with the cheaper price!


    ; --- 2. PRINT RECEIPT HEADER ---
PrintReceiptHeader:
    mov edx, OFFSET rcpt_title
    call WriteString
    
    ; --- 3. PRINT ROOM DETAILS ---
    mov edx, OFFSET str_room
    call WriteString
    mov edx, OFFSET cart_room_name      ; Prints "Standard Room"
    call WriteString
    call Crlf
    
    mov edx, OFFSET str_hours
    call WriteString
    mov eax, cart_room_hours            ; Prints the hours they typed
    call WriteDec
    call Crlf
    call Crlf
    
    ; --- 4. PRINT FOOD DETAILS (Conditional Loop) ---
    mov edx, OFFSET str_food
    call WriteString
    
CheckSnack1:
    cmp qty_snack1, 0                   ; Did they buy French Fries?
    je CheckSnack2                      ; If NO, jump to the next item!
    mov edx, OFFSET n_s1                ; If YES, print the name
    call WriteString
    mov edx, OFFSET str_times           ; Print " x "
    call WriteString
    mov eax, qty_snack1                 ; Print the quantity number
    call WriteDec
    call Crlf

CheckSnack2:
    cmp qty_snack2, 0
    je CheckSnack3
    mov edx, OFFSET n_s2
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_snack2
    call WriteDec
    call Crlf

CheckSnack3:
    cmp qty_snack3, 0
    je CheckDrink1
    mov edx, OFFSET n_s3
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_snack3
    call WriteDec
    call Crlf

CheckDrink1:
    cmp qty_drink1, 0
    je CheckDrink2
    mov edx, OFFSET n_d1
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_drink1
    call WriteDec
    call Crlf

CheckDrink2:
    cmp qty_drink2, 0
    je CheckDrink3
    mov edx, OFFSET n_d2
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_drink2
    call WriteDec
    call Crlf

CheckDrink3:
    cmp qty_drink3, 0
    je CheckMain1                  
    mov edx, OFFSET n_d3
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_drink3
    call WriteDec
    call Crlf

    CheckMain1:
    cmp qty_main1, 0
    je CheckMain2
    mov edx, OFFSET n_m1
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_main1
    call WriteDec
    call Crlf

CheckMain2:
    cmp qty_main2, 0
    je CheckMain3
    mov edx, OFFSET n_m2
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_main2
    call WriteDec
    call Crlf

CheckMain3:
    cmp qty_main3, 0
    je CheckCombo1
    mov edx, OFFSET n_m3
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_main3
    call WriteDec
    call Crlf

CheckCombo1:
    cmp qty_combo1, 0
    je CheckCombo2
    mov edx, OFFSET n_c1
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_combo1
    call WriteDec
    call Crlf

CheckCombo2:
    cmp qty_combo2, 0
    je CheckCombo3
    mov edx, OFFSET n_c2
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_combo2
    call WriteDec
    call Crlf

CheckCombo3:
    cmp qty_combo3, 0
    je CheckDessert1
    mov edx, OFFSET n_c3
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_combo3
    call WriteDec
    call Crlf

CheckDessert1:
    cmp qty_dessert1, 0
    je CheckDessert2
    mov edx, OFFSET n_ds1
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_dessert1
    call WriteDec
    call Crlf

CheckDessert2:
    cmp qty_dessert2, 0
    je CheckDessert3
    mov edx, OFFSET n_ds2
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_dessert2
    call WriteDec
    call Crlf

CheckDessert3:
    cmp qty_dessert3, 0
    je PrintGrandTotal
    mov edx, OFFSET n_ds3
    call WriteString
    mov edx, OFFSET str_times
    call WriteString
    mov eax, qty_dessert3
    call WriteDec
    call Crlf


    ; --- 5. PRINT GRAND TOTAL & DISCOUNT ---
PrintGrandTotal:
    cmp is_member, 1
    jne PrintFinalOnly          ; If Guest, just print the total.
    
    ; Print Member Details
    mov edx, OFFSET str_sub
    call WriteString
    mov eax, grand_total
    add eax, discount_amount    ; Temporarily reconstruct the original price to show them
    call WriteDec
    call Crlf
    
    mov edx, OFFSET str_disc
    call WriteString
    mov eax, discount_amount
    call WriteDec
    call Crlf
    
    mov edx, OFFSET str_earn
    call WriteString
    mov eax, points_earned
    call WriteDec
    call Crlf
    
PrintFinalOnly:
    mov edx, OFFSET str_total
    call WriteString
    mov eax, grand_total        ; Prints the final discounted RM amount!
    call WriteDec
    call Crlf
    call Crlf
    
    ; --- 6. TRANSITION TO PAYMENT ---
    mov edx, OFFSET payment_msg
    call WriteString
    call WaitMsg
    
    jmp PaymentPage                        ; For now, send back to Main Menu (Until Payment is built!)


    ; ====================================================================================================
; 7. PAYMENT GATEWAY
; ====================================================================================================
PaymentPage:
    call Clrscr
    mov edx, OFFSET pmt_title
    call WriteString
    
    ; --- Print Total Again for Convenience ---
    mov edx, OFFSET str_total
    call WriteString
    mov eax, grand_total
    call WriteDec
    call Crlf
    call Crlf
    
    ; --- Prompt for Cash ---
    mov edx, OFFSET pmt_prompt
    call WriteString
    call ReadDec                    ; User types their cash amount into EAX
    call Crlf
    
    ; --- Validation: Did they pay enough? ---
    cmp eax, grand_total            ; Compare their cash (EAX) to the bill
    jl PaymentFailed                ; JL (Jump if Less): If cash is too low, reject it!
    
    ; --- Calculate Change ---
    sub eax, grand_total            ; SUB: Subtracts grand_total FROM eax. EAX now holds the change!
    
    ; --- Print Success & Change ---
    mov edx, OFFSET pmt_change
    call WriteString
    call WriteDec                   ; Prints the change sitting in EAX
    call Crlf
    call Crlf
    
    mov edx, OFFSET pmt_ty
    call WriteString
    call WaitMsg
    jmp ResetCartSystem             ; clear the memory for the next customer

PaymentFailed:
    mov edx, OFFSET pmt_err
    call WriteString
    call WaitMsg
    jmp PaymentPage                 ; Force them to try paying again



    ; ====================================================================================================
; 8. SYSTEM RESET (Clear Cart for Next User)
; ====================================================================================================
ResetCartSystem:
    mov cart_room_price, 0
    mov cart_room_hours, 0
    mov cart_food_total, 0
    mov grand_total, 0
    
    mov qty_snack1, 0
    mov qty_snack2, 0
    mov qty_snack3, 0
    
    mov qty_drink1, 0
    mov qty_drink2, 0
    mov qty_drink3, 0
    
    mov qty_main1, 0
    mov qty_main2, 0
    mov qty_main3, 0
    
    mov qty_combo1, 0
    mov qty_combo2, 0
    mov qty_combo3, 0
    
    mov qty_dessert1, 0
    mov qty_dessert2, 0
    mov qty_dessert3, 0

    ; Add the points to their account!
    mov eax, points_earned
    add current_pts, eax
    
    ; =========================================
    ; --- THE FIX: SAVE TO DATABASE ON CHECKOUT ---
    ; =========================================
    cmp is_member, 1            ; Did a logged-in member just check out?
    jne SkipSave                ; If guest, skip the saving process!

    ; 1. Convert Points to Text
    call ConvertPtsToString

    ; 2. Open File
    INVOKE CreateFile, OFFSET Cfilename, GENERIC_WRITE, 0, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
    mov CfileHandle, eax

    ; 3. Move to bottom of file
    INVOKE SetFilePointer, CfileHandle, 0, 0, FILE_END

    ; 4. Write Username
    INVOKE Str_length, ADDR current_user
    mov ecx, eax
    mov eax, CfileHandle
    mov edx, OFFSET current_user
    call WriteToFile

    ; 5. Write Comma
    mov eax, CfileHandle
    mov edx, OFFSET comma_str
    mov ecx, 1
    call WriteToFile

    ; 6. Write Scrambled Password
    mov eax, CfileHandle
    mov edx, OFFSET Clogin_pass
    mov ecx, Clogin_pass_len
    call WriteToFile

    ; 7. Write Comma
    mov eax, CfileHandle
    mov edx, OFFSET comma_str
    mov ecx, 1
    call WriteToFile

    ; 8. Write Converted Points
    mov eax, CfileHandle
    mov edx, OFFSET pts_buffer
    add edx, 19
    sub edx, pts_len
    mov ecx, pts_len
    call WriteToFile

    ; 9. Write Newline
    mov eax, CfileHandle
    mov edx, OFFSET newline
    mov ecx, 2
    call WriteToFile

    ; 10. Close File
    mov eax, CfileHandle
    call CloseFile

SkipSave:
    ; <--- Wipe the trackers for the next customer! --->
    mov points_spent, 0
    mov points_earned, 0
    
    ; Wipe the member status & Username Safe Box
    mov is_member, 0
    INVOKE Str_copy, ADDR comma_str, ADDR current_user
    
    jmp MainMenu                    ; Kiosk is fully reset and ready for the next person!


; ==============================================================================================================================================================



;================================================================ 3. EXIT =======================================================================


; --- EXIT ---
ExitKiosk:
    exit                        ; Safely kills the program

    main    endp

; ==============================================================================================================================================================













;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& R E G I S T R A T I O N    B A C K   S Y S T E M &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    
; ---------------------------------------------------------- REGISTER CUSTOMER ----------------------------------------------------------------


.code

RegisterCust PROC
    call Clrscr

    ; =========================================
    ; 1. GET THE USERNAME
    ; =========================================
    mov edx, OFFSET Creg_title
    call WriteString
    call Crlf
    mov edx, OFFSET prompt_user
    call WriteString
    
    mov edx, OFFSET Cusername        ; Tell Irvine WHERE to save the typing
    mov ecx, 50                     ; Tell Irvine the MAXIMUM letters allowed
    call ReadString                 ; When this finishes, EAX holds the exact letter count
    mov Cname_len, eax               ; Save that count! We need it for the file writer.

    ; =========================================
    ; 2. GET THE PASSWORD
    ; =========================================
    mov edx, OFFSET prompt_pass
    call WriteString
    
    mov edx, OFFSET Cpassword
    mov ecx, 50
    call ReadString
    mov Cpass_len, eax               ; Save the password length

    ; =========================================
    ; 3. THE XOR ENCRYPTION LOOP
    ; =========================================
    mov esi, OFFSET Cpassword        ; ESI acts like a finger pointing at the first letter
    mov ecx, Cpass_len               ; Set our loop counter to the length of the password
    mov al, Csecret_key              ; Load our secret key into the AL register

    cmp ecx, 0                      ; Safety check: Did they just press Enter without typing?
    je WriteData                    ; If yes, skip the loop so it doesn't crash

EncryptLoop:
    xor BYTE PTR [esi], al          ; Scramble the single letter ESI is pointing at
    inc esi                         ; Move the finger to the next letter
    loop EncryptLoop                ; Subtract 1 from ECX and jump back if not 0

    ; =========================================
    ; 4. SAVE TO FILE
    ; =========================================
WriteData:
    ; A. Open the file in APPEND mode (Talking directly to Windows API)
    INVOKE CreateFile,
        OFFSET Cfilename,
        GENERIC_WRITE,          ; Request write access
        0,                      ; Don't share the file while we use it
        0,                      ; Security (Null)
        OPEN_ALWAYS,            ; CRITICAL: Open if it exists, create if it doesn't!
        FILE_ATTRIBUTE_NORMAL,  ; Normal file type
        0
    mov CfileHandle, eax         ; Save the Windows file ID

    ; B. Move the text cursor to the very bottom of the file
    INVOKE SetFilePointer,
        CfileHandle,
        0,                      ; Move 0 bytes...
        0,                      
        FILE_END                ; ...from the END of the file. (Cursor is now at the bottom!)

    ; C. Write the Username
    mov eax, CfileHandle
    mov edx, OFFSET Cusername
    mov ecx, Cname_len
    call WriteToFile

    ; D. Write the Comma
    mov eax, CfileHandle
    mov edx, OFFSET comma_str
    mov ecx, 1
    call WriteToFile

    ; E. Write the Scrambled Password
    mov eax, CfileHandle
    mov edx, OFFSET Cpassword
    mov ecx, Cpass_len
    call WriteToFile

; --- E.5 Write another comma ---
    mov eax, CfileHandle
    mov edx, OFFSET comma_str
    mov ecx, 1
    call WriteToFile
    
    ; --- E.6 Write the starting points ---
    mov eax, CfileHandle
    mov edx, OFFSET start_points
    mov ecx, 3                      ; "100" is 3 letters long!
    call WriteToFile
    
    ; F. Write the New Line (So the next customer starts on a fresh line!)
    mov eax, CfileHandle
    mov edx, OFFSET newline
    mov ecx, 2
    call WriteToFile
    
    ; G. Close the File (CRITICAL)
    mov eax, CfileHandle
    call CloseFile
    
    call Crlf
    mov edx, OFFSET success_msg
    call WriteString
    call Crlf
    call WaitMsg
    ret                             ; 'Return' sends the CPU back to the Main Menu

RegisterCust ENDP

; ---------------------------------------------------------- LOGIN CUSTOMER ----------------------------------------------------------------


.code

CLoginUser PROC
    call Clrscr

    ; =========================================
    ; 1. GET LOGIN CREDENTIALS
    ; =========================================
    mov edx, OFFSET prompt_l_user   ; Prompt for Username
    call WriteString
    mov edx, OFFSET Clogin_user
    mov ecx, 50
    call ReadString
    mov Clogin_user_len, eax

    mov edx, OFFSET prompt_l_pass   ; Prompt for Password
    call WriteString
    mov edx, OFFSET Clogin_pass
    mov ecx, 50
    call ReadString
    mov Clogin_pass_len, eax

    ; =========================================
    ; THE SECURITY FIX: Block Empty Inputs
    ; =========================================
    cmp Clogin_user_len, 0          ; Did they leave the username blank?
    je LoginFailed                  ; Instantly jump to the fail screen!

    cmp Clogin_pass_len, 0          ; Did they leave the password blank?
    je LoginFailed                  ; Instantly jump to the fail screen!

    ; =========================================
    ; 2. SCRAMBLE THE PASSWORD (Must match registration!)
    ; =========================================
    mov esi, OFFSET Clogin_pass
    mov ecx, Clogin_pass_len
    mov al, Csecret_key              ; Uses the same 'Csecret_key' from your data segment

    cmp ecx, 0
    je LoadDatabase                 ; Skip if password is blank

ScrambleLogin:
    xor BYTE PTR [esi], al
    inc esi
    loop ScrambleLogin

    ; =========================================
    ; 3. LOAD THE HAYSTACK (Read the text file)
    ; =========================================
LoadDatabase:
    mov edx, OFFSET Cfilename
    call OpenInputFile              ; Irvine function to open an existing file
    
    cmp eax, INVALID_HANDLE_VALUE   ; Did the file fail to open? (e.g., it doesn't exist yet)
    je FileNotFound                 ; If yes, jump to error
    mov CfileHandle, eax             ; Otherwise, save the ID!

    ; Read the data into our giant buffer
    mov eax, CfileHandle
    mov edx, OFFSET Cfile_buffer
    mov ecx, 1024                   ; Read up to 1024 bytes
    call ReadFromFile
    mov Cbytes_read, eax             ; Save how many bytes were actually in the file
    
    mov eax, CfileHandle
    call CloseFile                  ; Always close the file immediately after reading!

    ; =========================================
    ; 4. BUILD THE NEEDLE (Manually gluing text)
    ; =========================================
    
    ; A. Copy the typed username into the target buffer
    INVOKE Str_copy, ADDR Clogin_user, ADDR Csearch_target

    ; B. Get the length of the username so we know where to put the comma
    INVOKE Str_length, ADDR Csearch_target
    mov edi, OFFSET Csearch_target  ; Point EDI to the start of the target buffer
    add edi, eax                    ; Move EDI forward to the exact end of the username

    ; C. Add the comma manually
    mov al, ','                     ; Load comma into AL
    mov [edi], al                   ; Put comma at the end of the username
    inc edi                         ; Move EDI forward one space

    ; D. Copy the scrambled password right after the comma
    INVOKE Str_copy, ADDR Clogin_pass, edi

    ; *Now, search_target exactly equals "admin,scrambled"*
    INVOKE Str_length, ADDR Csearch_target
    mov ebx, eax                    ; Save the final total length of our Needle in EBX

   ; =========================================
    ; 5. SEARCH THE HAYSTACK (Manual CPU Loop)
    ; =========================================
    mov ecx, Cbytes_read             
    mov esi, OFFSET Cfile_buffer     
    mov last_match_ptr, 0           ; <--- RESET: Clear the tracker for a fresh search!
    
    cmp ecx, 0                      
    je LoginFailed

SearchLoop:
    mov edi, OFFSET Csearch_target   
    mov edx, 0                      

CompareLetters:
    mov al, BYTE PTR [esi + edx]    
    mov ah, BYTE PTR [edi + edx]    

    cmp al, ah                      
    jne NextStartingLetter          

    inc edx                         
    cmp edx, ebx                    
    je RecordMatch                  ; <--- THE FIX: Don't stop! Jump to RecordMatch!

    jmp CompareLetters              

RecordMatch:
    mov last_match_ptr, esi         ; Save the exact memory address of this match
    jmp NextStartingLetter          ; Force the CPU to keep checking the rest of the file!

NextStartingLetter:
    inc esi                         
    loop SearchLoop                 

    ; =========================================
    ; 6. ROUTING & PARSING THE LAST MATCH
    ; =========================================
    cmp last_match_ptr, 0           ; Did we ever find a match?
    je LoginFailed                  ; If 0, no account exists!
    
    ; --- WE FOUND IT! LOAD THE LATEST RECORD ---
    mov esi, last_match_ptr         ; Teleport ESI directly to the LAST match at the bottom!
    add esi, ebx                    ; Move ESI past the "username,password"
    inc esi                         ; Move ESI past the comma (pointing at first digit)
    
    mov eax, 0                      ; EAX will hold our final loaded points
    mov ecx, 10                     ; Multiplier for the digits
    
ParseLoop:
    mov bl, BYTE PTR [esi]          
    cmp bl, 13                      
    je ParseDone
    cmp bl, 0                       
    je ParseDone
    cmp bl, ','                     
    je ParseDone
    
    sub bl, '0'                     
    movzx ebx, bl                   
    
    push edx                        
    mul ecx                         
    pop edx
    
    add eax, ebx                    
    inc esi                         
    jmp ParseLoop
    
ParseDone:
    mov current_pts, eax            ; Save the latest points!
    
    ; --- NOW PRINT SUCCESS! ---
    mov edx, OFFSET msg_success
    call WriteString
    call Crlf
    
    INVOKE Str_copy, ADDR Clogin_user, ADDR current_user
    
    call WaitMsg
    mov eax, 1                      
    ret                             

LoginFailed:
    mov eax, 12                 ; 12 = Light Red
    call SetTextColor
    
    mov edx, OFFSET msg_fail
    call WriteString
    
    mov eax, 8                 ; CHANGE IT BACK TO WHITE IMMEDIATELY!
    call SetTextColor
    
    call WaitMsg
    mov eax, 0                      
    ret                           

FileNotFound:
    mov edx, OFFSET msg_no_file
    call WriteString
    call WaitMsg
    mov eax, 0                      
    ret                             

CLoginUser ENDP



; ====================================================================
; CONVERT DWORD TO STRING (To save points to file)
; ====================================================================
ConvertPtsToString PROC
    mov eax, current_pts
    mov ecx, 10
    mov edi, OFFSET pts_buffer
    add edi, 19                 ; Start at the end of the buffer
    mov BYTE PTR [edi], 0       ; Null terminator
    dec edi
    mov pts_len, 0

ConvertLoop:
    mov edx, 0
    div ecx                     ; Divide by 10. Remainder is in EDX (the last digit)
    add dl, '0'                 ; Convert digit to ASCII letter
    mov [edi], dl               ; Save letter to buffer
    dec edi
    inc pts_len
    cmp eax, 0                  ; Are we out of numbers?
    jne ConvertLoop
    
    inc edi                     ; Point EDI to the exact start of the string
    mov edx, edi                ; EDX now holds the memory address of the string!
    ret

ConvertPtsToString ENDP


; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

end    main