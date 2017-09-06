trigger ABC_Bestpractice on Contact (before insert) {  
    if(Trigger.isbefore){
     if( Trigger.isInsert)
    {
        ABC_Handler.Account_Contact_Association(Trigger.new);
    }
    }    
}