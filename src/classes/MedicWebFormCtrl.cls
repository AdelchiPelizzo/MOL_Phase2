/**
 * Created by Adelchi on 22/03/2018.
 */

public with sharing class MedicWebFormCtrl {

    public Contact contct {get;set;}
    public Consultation__c conslt {get;set;}
    public Medication_Prescribed__c medcPresc {get;set;}
    public Diagnostic_Code__c diagCode {get;set;}
    public static List<String> listOfFields {get{
        List<String> listOfFields = new List<String>();
        listOfFields.addAll(Consultation__c.SObjectType.getDescribe().fields.getMap().keySet());
        return listOfFields;

    }set;}


    public void MedicWebFormCtrl(){
        listOfFields = new List<String>();
        listOfFields.addAll(Consultation__c.SObjectType.getDescribe().fields.getMap().keySet());
        system.debug(listOfFields);

    }

}