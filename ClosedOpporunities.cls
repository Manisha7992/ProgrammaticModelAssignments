public with sharing class ClosedOpporunities{
    
    /**Aggregate function to display closed won opportunity records**/
    public void closedOpportunity()
    {
        AggregateResult[] listedClosedOpportunities = [Select sum(Amount) 
                                                       FROM Opportunity 
                                                       WHERE StageName in ('Closed Won','Closed Lost') and CloseDate = THIS_FISCAL_YEAR];
        String currentFiscalYear = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY].FiscalYearSettings.Name;
        System.debug('Current fiscal year '+currentFiscalYear );
       
        Map<String,Double> mapFiscalYear = new Map<String,Double>();
        Object obj = listedClosedOpportunities[0].get('expr0');
        System.debug('Total amount'+obj);
        
        Double amount=Double.valueof(obj);
        System.debug('Amount'+amount);
        
        mapFiscalYear.put(currentFiscalYear,amount);
        System.debug('Map '+mapFiscalYear);
    }
    
}