public class EquipmentTransactionController 
{
    public final   Equipment__c equipment{get;set;}
    public final   EditorialHardwareTracking__c equipmentTransaction{get;set;}
    public string  operation {get;set;}
    
    public EquipmentTransactionController(ApexPages.StandardController controller) 
    {
        // Get details of the equipment from DB
        equipment =[select id, Make__c, Model__c, Serial__c, Status__c from Equipment__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        
        operation=ApexPages.currentPage().getParameters().get('op');       

        if(operation=='faulty') 
        {
            equipment.Status__c='Faulty'; 
        }
        else if (operation=='redundant')
        {
            equipment.Status__c='Redundant';  
        }    
        else if (operation=='checkin')
        {
            // Get details of the transaction which needs to be checkin 
            equipmentTransaction =[select id, DateIn__c, Editorial_Equipment__c,Borrowers_Email__c,Check_In_Comments__c,Check_Out_Comments__c  from EditorialHardwareTracking__c  WHERE DateIn__c=NULL AND Editorial_Equipment__c = :ApexPages.currentPage().getParameters().get('id') limit 1 ];    
            equipment.Status__c='Available';
        } 
        else if (operation=='loan')
        {
            equipmentTransaction= new EditorialHardwareTracking__c(Editorial_Equipment__c=equipment.id);
            equipment.Status__c='On Loan';
        } 
        else if (operation=='permloan')
        {
            equipmentTransaction= new EditorialHardwareTracking__c(Editorial_Equipment__c=equipment.id);
            equipment.Status__c='Permanent Loan';    
        }                                    
    }   

    /**
    * @author Deepak Gupta
    * @create date 05/10/2012
    * @description - 
    **/     
    public pageReference saveTransaction()
    {
        // Transaction need to be upserted in all cases except for Marking it Faulty/Redundant
        if(operation!='faulty' && operation!='redundant')  upsert equipmentTransaction;
        
        update equipment;
        
        PageReference redirectPage = new pageReference('/'+ equipment.Id);
        redirectPage.setRedirect(true);
        return redirectPage;   
    }    

    /**
    * @author Deepak Gupta
    * @create date 05/10/2012
    * @description - 
    **/     
    public pageReference cancel()
    {
        PageReference redirectPage = new pageReference('/'+ equipment.Id);
        redirectPage.setRedirect(true);
        return redirectPage;   
    }        
}