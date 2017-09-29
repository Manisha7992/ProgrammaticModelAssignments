/** Test class for dynamicapex controller **/
@isTest
private class DynamicSOQLSchemaControllerTest 
{

    @testSetup
    static void datafactory() 
    {
        TestDataFactory.createAccounts(100);
    }
    
    static testMethod void testForAccountObject() 
    {
        Test.startTest();
        SchemaController controller = new SchemaController();
        controller.selectedObj = 'account';
        controller.details();
        Test.stopTest();
        System.assert(controller.fields != NULL);
        System.assert(controller.fnotselected != NULL);
        System.assert(controller.fselected.isEmpty());
        System.assertEquals(true,controller.isObjSelected,'isObjSelected not changed to TRUE. Hence other sections wont be rendered');
        System.assertEquals(controller.fnsoptions.size(),controller.fields.size(),'All fields of newly selected object not added to unselected fields picklist');
        System.assert(controller.fsoptions.isEmpty());
    }
    
     static testMethod void testFieldSelectedScenario()
    {
        Test.startTest();
        SchemaController controller = new SchemaController();
        controller.selectedObj = 'account';
        controller.details();
        controller.sfields.add('AccountNumber');
        controller.sfields.add('Name');
        controller.addFields();
        Test.stopTest();
        System.assert(controller.fselected != NULL,'New selected fields are not added to selected fields picklist');
        System.assert(controller.fselected.contains('AccountNumber'),'Selected fields picklist does not contain AccountNumber');
        System.assert(controller.fselected.contains('Name'),'Selected fields picklist does not contain Name');
        System.assert(!controller.fnotselected.contains('AccountNumber'),'AccountNumber is not removed from Fields not selected picklist');
        System.assert(!controller.fnotselected.contains('Name'),'Name is not removed from Fields not selected picklist');
        controller.rfields.add('AccountNumber');
        controller.removeFields();
        System.assert(controller.fnotselected.contains('AccountNumber'),'Not selected fields picklist does not contain AccountNumber after removing it');
        System.assert(!controller.fselected.contains('AccountNumber'),'AccountNumber is not removed from Fields selected picklist');
    }
    static testMethod void testNoneObjectSelectedScenario()
    {
        Test.startTest();
        SchemaController controller = new SchemaController();
        controller.selectedObj = 'account';
        controller.details();
        controller.sfields.add('AccountNumber');
        controller.sfields.add('Name');
        controller.addFields();
        controller.selectedObj = 'None';
        controller.details();
        Test.stopTest();
        System.assertEquals(false,controller.isObjSelected,'isObjSelected not changed to FALSE. Hence other sections will still be rendered');
        System.assertEquals(false,controller.isQueryExecuted,'isQueryExecuted not changed to FALSE. Hence query and result sections will still be rendered');
    }
      static testMethod void testExecuteQueryScenario()
    {
        Test.startTest();
        SchemaController controller = new SchemaController();
        controller.selectedObj = 'account';
        controller.details();
        controller.sfields.add('AccountNumber');
        controller.sfields.add('Name');
        controller.addFields();
        System.assertEquals(false,controller.isQueryExecuted,'isQueryExecuted not set to FALSE. Hence query and result sections will be rendered prior');
        controller.queryData();
        System.assertEquals(true,controller.isQueryExecuted,'isQueryExecuted not changed to TRUE. Hence query and result sections will not be rendered');
        System.assertEquals('SELECT AccountNumber,Name FROM account ORDER BY Id ASC LIMIT 500',controller.query,'Query being built is not similar to what is expected');
        System.assertEquals(10,controller.mydata.size(),'Queried data is not same in number as that of inserted');
        controller.rfields.add('AccountNumber');
        controller.removeFields();
        controller.queryData();
        Test.stopTest();
        System.assertEquals('SELECT Name FROM account ORDER BY Id ASC LIMIT 500',controller.query,'After removing fields query is not reflecting those changes');
        System.assertEquals(10,controller.mydata.size(),'Queried data is not same in number as that of inserted');
    }
     static testMethod void testExecuteQueryWithNoFieldsScenario()
    {
        Test.startTest();
        PageReference pageRef = Page.SchemaBuilder;
        Test.setCurrentPage(pageRef);
        SchemaController controller = new SchemaController();
        controller.selectedObj = 'account';
        controller.details();
        System.assertEquals(false,controller.isQueryExecuted,'isQueryExecuted not set to FALSE. Hence query and result sections will be rendered prior');
        controller.queryData();
        Test.stopTest();
        System.assertEquals('SELECT  FROM account ORDER BY Id ASC LIMIT 500',controller.query,'Query being built is not similar to what is expected');
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        System.assertEquals('Please select few fields to query',msgs[0].getDetail(),'Page is not returing error message even when no fields are selected');
    }
    static testMethod void testExecuteQueryWithInvalidFieldsScenario()
    {
        Test.startTest();
        PageReference pageRef = Page.SchemaBuilder;
        Test.setCurrentPage(pageRef);
        SchemaController controller = new SchemaController();
        controller.selectedObj = 'account';
        controller.details();
        controller.sfields.add('LastName');
        controller.addFields();
        controller.queryData();
        Test.stopTest();
        System.assertEquals(controller.fselected.size(),controller.myFields.size());
        System.assertEquals('SELECT LastName FROM account ORDER BY Id ASC LIMIT 500',controller.query,'Query being built is not similar to what is expected');
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        System.assertEquals('No such column \'LastName\' on entity \'Account\'. If you are attempting to use a custom field, be sure to append the \'__c\' after the custom field name. Please reference your WSDL or the describe call for the appropriate names.',msgs[0].getDetail(),'Page is not returing error message even when invalid fields are selected');
    }
}