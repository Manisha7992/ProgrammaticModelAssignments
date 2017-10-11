public with sharing class MasterDetailRelationshipABC{
    
     /**ParenttoChild from A,B and C**/
    public void parentChildRelationship()
    {
        List<C__c> childRecords=[SELECT AandC__r.id,AandC__r.name,BandC__r.id,BandC__r.name,Name,ID FROM C__c];
        System.debug(' A,B,C Records are:'+childRecords)   ;   
    }
       
}