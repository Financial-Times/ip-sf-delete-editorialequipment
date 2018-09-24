/**
* @description This is extension controller for ViewEquipment VF
* 
* Change Log 
*
* Date        Author          Change Description
* -----------------------------------------------------------------------------
* 05/10/2012  Deepak Gupta     Original Version
* 09/11/2012  Graeme Cameron   Update. Includes fix for making record available again after marked redundant

*/
public class ViewEquipmentController 
{
    public final   Equipment__c equipment{get;set;}
    public boolean showPermLoan {get;set;}
    public boolean showCheckIn {get;set;}    
    public boolean showCheckOut {get;set;}
    public boolean showMarkFaulty {get;set;}
    public boolean showMarkRedundant {get;set;}
    public boolean showMarkAvailable {get;set;}

    /**
    * @author Deepak Gupta
    * @create date 05/10/2012
    * @description - Constructor class for the ViewEquipmentController
    **/       
    public ViewEquipmentController(ApexPages.StandardController controller) 
    {  
        equipment =[select id, Status__c from Equipment__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        
        if (equipment.Status__c=='Available') 
        {
            showPermLoan=true;    
            showCheckOut=true;  
            showMarkFaulty=true;  
            showMarkRedundant=true;     
            showCheckIn=false;  
            showMarkAvailable=false;
        } 
        else if (equipment.Status__c=='On Loan' || equipment.Status__c=='Permanent Loan')
        {
            showPermLoan=false;    
            showCheckOut=false;  
            showMarkFaulty=false;  
            showMarkRedundant=false;    
            showCheckIn=true;  
            showMarkAvailable=false;
        } 
        else if (equipment.Status__c=='Faulty') 
        {
            showPermLoan=false;    
            showCheckOut=false;  
            showMarkFaulty=false;  
            showCheckIn=false;  
            showMarkRedundant=false;
            showMarkAvailable=true;
        }
        else if (equipment.Status__c=='Redundant') 
        {
            showPermLoan=false;    
            showCheckOut=false;  
            showMarkFaulty=false;  
            showMarkRedundant=false;    
            showCheckIn=false;
            showMarkAvailable=true;
        }
    }
    
    /**
    * @author Deepak Gupta
    * @create date 05/10/2012
    * @description - Redirects to record Edit page
    **/     
    public pageReference editRecord()
    {
        PageReference redirectPage = new pageReference('/'+equipment.Id+'/e?retURL='+equipment.Id);
        //redirectPage.setRedirect(true);
        redirectPage.setRedirect(true);
        return redirectPage;   
    }    

    /**
    * @author Deepak Gupta
    * @create date 05/10/2012
    * @description - 
    **/     
    public pageReference permanentLoan()
    {
        PageReference redirectPage = new pageReference('/apex/EquipmentTransaction?id='+equipment.Id+'&op=permloan');
        redirectPage.setRedirect(true);
        return redirectPage;   
    }

    /**
    * @author Deepak Gupta
    * @create date 05/10/2012
    * @description - 
    **/     
    public pageReference checkIn()
    {
        PageReference redirectPage = new pageReference('/apex/EquipmentTransaction?id='+equipment.Id+'&op=checkin');
        redirectPage.setRedirect(true);
        return redirectPage;   
    }   
    
    /**
    * @author Deepak Gupta
    * @create date 05/10/2012
    * @description - 
    **/     
    public pageReference checkOut()
    {
        PageReference redirectPage = new pageReference('/apex/EquipmentTransaction?id='+equipment.Id+'&op=loan');
        redirectPage.setRedirect(true);
        return redirectPage;   
    }
    
    /**
    * @author Deepak Gupta
    * @create date 05/10/2012
    * @description - 
    **/     
    public pageReference markFaulty()
    {
        PageReference redirectPage = new pageReference('/apex/EquipmentTransaction?id='+equipment.Id+'&op=faulty');
        redirectPage.setRedirect(true);
        return redirectPage;  
    }

    /**
    * @author Deepak Gupta
    * @create date 02/11/2012
    * @description - 
    **/     
    public pageReference markAvailable()
    {
        equipment.Status__c='Available';
        Update equipment;
        
        PageReference redirectPage = new pageReference('/apex/ViewEquipment?id='+equipment.Id);
        redirectPage.setRedirect(true);
        return redirectPage; 
    }
    
    /**
    * @author Deepak Gupta
    * @create date 05/10/2012
    * @description - 
    **/     
    public pageReference markRedundant()
    {
        PageReference redirectPage = new pageReference('/apex/EquipmentTransaction?id='+equipment.Id+'&op=redundant');
        redirectPage.setRedirect(true);
        return redirectPage;  
    }
   
}// End of Class