public with sharing class Closedopp {
	
	
	//Aggregate function for opportunity records
	public void closedOpportunity(){
		AggregateResult[] lstclosedopp = [Select sum(Amount) from Opportunity where StageName in ('Closed Won','Closed Lost') and CloseDate = THIS_FISCAL_YEAR];
		String currentFiscalYear = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY].FiscalYearSettings.Name;
		System.debug('Current fiscal year '+currentFiscalYear );
		Map<String,Double> mapfiscalyear_amount = new Map<String,Double>();
		Object obj = lstclosedopp[0].get('expr0');
		System.debug('Total amount' +obj);
		//Integer amount =Integer.valueOf(obj);
		Double amount=Double.valueof(obj);
		System.debug('Amount '+amount);
		mapfiscalyear_amount.put(currentFiscalYear,amount);
		System.debug('Map '+ mapfiscalyear_amount);
 	}
    
}