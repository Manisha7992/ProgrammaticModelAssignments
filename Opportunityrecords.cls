public with sharing class OpportunityRecords {

//Displaying opportunity records based on amount
public void oppRecords()
{	
List<Opportunity> opp=[Select id,name
                       FROM Opportunity
                       WHERE Amount>10000
                       ORDER BY Createddate
                       LIMIT 100
                       OFFSET 50 
                       ALL ROWS
                       ];
                       
for(Opportunity oppo:opp)
{
System.debug('Opportunity names whose amount is greater than 10000 are');
System.debug(oppo);
}                                             
}
   
}