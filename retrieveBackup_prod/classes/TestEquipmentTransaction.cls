/**
* @description Test class for EquipmentTransaction Class
* 
* Change Log 
*
* Date        Author          Change Description
* ------------------------------------------------------------------------------------
* 10/10/2012  Deepak Gupta      Created
*/
@isTest(SeeAllData=True)
public class TestEquipmentTransaction
{   
    /**
    * @author Deepak Gupta
    * @create date 10/10/2012
    * @description - Test method for testing EquipmentTransaction Class
    **/     
    public static testMethod void EquipmentTransactionTest()
    {
        //Create test equipment 
        Equipment__c equipment = new Equipment__c(Make__c='Test Make',
                                                    FTnumber__c='Test Data',
                                                    Model__c = 'TMaodel', 
                                                    Serial__c = '8545'                                                  
                                                    );
        insert equipment; 
        
        //Test.setCurrentPage(new pageReference('apex/EquipmentTransaction'));               
        Test.setCurrentPage(new pageReference('apex/EquipmentTransaction'));               
        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('Id',equipment.Id ); 
        ApexPages.currentPage().getParameters().put('op','permloan' );      
        Test.starttest();        
        ApexPages.StandardController ctlr = new ApexPages.StandardController(equipment);
        EquipmentTransactionController controller = new EquipmentTransactionController(ctlr);
        
        // Now test various pieces of functionality
        //Test.starttest();        
        controller.saveTransaction();
        controller.cancel();
        Test.stoptest();        
    }   // End of methos
    
    /**
    * @author Deepak Gupta
    * @create date 10/10/2012
    * @description - Helper method for getting details of an equipment
    **/              
    private static Equipment__c  queryEquipment(Id equipmentId)
    {
        return([select Id from Equipment__c where Id =: equipmentId]);
    }        
}