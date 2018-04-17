/**
 * Created by Adelchi on 14/04/2018.
 */

public with sharing class MedicationPrescriptionCtrl {

    public static Consultation__c consultation;
    public static Inventory__c iRecord;
    public static Medication_Prescribed__c medPrescribed;
    public static Site__c site;


/*    @AuraEnabled
    public static void getInventoryItem(String InventoryName){
        iRecord = [SELECT Id, Available__c, Removal_Reason__c FROM Inventory__c WHERE Name =: InventoryName AND Available__c = true LIMIT 1];
        setInventoryItem();
    }*/

   @AuraEnabled
    public static void getInventoryItem(String consultId, String InventoryName){
       system.debug(InventoryName+'xxxxx'+consultId);
       consultation = [SELECT Site__c FROM Consultation__c WHERE Id =: consultId LIMIT 1];
       iRecord = [SELECT Id, Available__c, Removal_Reason__c FROM Inventory__c WHERE SiteName__c =: consultation.Site__c AND Name =: InventoryName AND Available__c = true LIMIT 1];
       setInventoryItem(consultId);
    }

    @AuraEnabled
    public static void setInventoryItem(String conId){
        iRecord.Available__c = False;
        iRecord.Removal_Reason__c = 'Used';
        iRecord.Consultation__c = conId;
        update iRecord;
    }

    @AuraEnabled
    public static List < String > getMedicationList(){
        system.debug('get medication list method started ');
        Medication_Prescribed__c mp = new Medication_Prescribed__c();
        List < String > medicationList = fetchPickList.getselectOptions(mp, 'Medication_Name__c');
        return medicationList;
    }

}