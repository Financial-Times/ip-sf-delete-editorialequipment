/**
* @description Test class for ViewEquipmentController Class
* 
* Change Log 
*
* Date        Author          Change Description
* ------------------------------------------------------------------------------------
* 10/10/2012  Deepak Gupta      Created
*/
@isTest(SeeAllData=True)
public class TestViewEquipmentController
{   
    /**
    * @author Deepak Gupta
    * @create date 10/10/2012
    * @description - Test method for testing ViewEquipmentController Class
    **/     
    public static testMethod void ViewEquipmentControllerTest()
    {
        //Create test equipment 
        Equipment__c equipment = new Equipment__c(Make__c='Test Make',
                                                    FTnumber__c='Test Data', 
                                                    Model__c = 'TMaxxl', 
                                                    Serial__c = '8545566'                                                  
                                                    );
        insert equipment; 
        
        //Test.setCurrentPage(new pageReference('apex/ViewEquipment')); 
        Test.setCurrentPage(new pageReference('apex/ViewEquipment'));                        
        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('Id',equipment.Id );               
        ApexPages.StandardController ctlr = new ApexPages.StandardController(equipment);
        ViewEquipmentController controller = new ViewEquipmentController(ctlr);
        
        // Now test various pieces of functionality
        Test.starttest();        
        controller.editRecord();
        controller.permanentLoan();
        controller.checkOut();
        controller.checkIn();           
        controller.markFaulty();
        controller.markRedundant();                    
        Test.stoptest();        
    }   // End of methos

    /**
    * @author Deepak Gupta
    * @create date 10/10/2012
    * @description - Test method for testing ViewEquipmentController Class
    **/     
    public static testMethod void ViewEquipmentControllerTest2()
    {
        //Create test equipment       
        Equipment__c equipment2 = new Equipment__c(Make__c='Test Make',
                                                    FTnumber__c='Test Data',
                                                    Status__c='Permanent Loan', 
                                                    Model__c = 'TMaxx Model', 
                                                    Serial__c = '8545566666'                                                 
                                                    );
        insert equipment2; 
        
        Test.setCurrentPage(new pageReference('apex/ViewEquipment'));               
        // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('Id',equipment2.Id );               
      
        
        // Now test various pieces of functionality
        Test.starttest();        
        
        ApexPages.StandardController ctlr = new ApexPages.StandardController(equipment2);
        ViewEquipmentController controller = new ViewEquipmentController(ctlr);  
                
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