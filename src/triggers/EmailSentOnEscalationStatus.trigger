/**
 * Created by Adelchi on 30/01/2018.
 */

trigger EmailSentOnEscalationStatus on Consultation__c (after insert , after update) {
    List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
    String MyProfileName = PROFILE[0].Name;
    for(Consultation__c newConsultation : Trigger.new){
        Boolean newConsultationIsSubmitted = newConsultation.status__c.contains('Submitted');
        Boolean newConsultationIsReviewed = newConsultation.status__c.contains('Reviewed');
        Boolean newConsultationIsClosed = newConsultation.status__c.contains('Closed');
        List<String> listIdStrings = new List<String>();
        listIdStrings.add(newConsultation.Id);




        if(trigger.isInsert){
            if(newConsultationIsClosed){
                if(MyProfileName == 'Partner Community User - Clone - Doctor'){
                    SendEmailConsultationStatusReviewed.sendEmailToMedicAndNonMedic(listIdStrings);
                }
                /*else if(MyProfileName=='Partner Community User - Clone'){
                    system.debug('Partner Community User - Clone');
                }*/
            }/*
            else if(newConsultationIsSubmitted){
                if(MyProfileName == 'Partner Community User - Clone' ){
                    system.debug('Partner Community User - Clone');
                }else if(MyProfileName == 'Partner Community User - Clone - Doctor'){
                    system.debug('Partner Community User - Clone - Doctor');
                }
            }*/
        }else if(trigger.isUpdate){
            if(newConsultationIsReviewed){
                if(MyProfileName == 'Partner Community User - Clone - Doctor'){
                    SendEmailConsultationStatusReviewed.sendEmailToMedicAndNonMedic(listIdStrings);
                }/*else if(MyProfileName=='Partner Community User - Clone'){

                }*/
            }
            else if(newConsultationIsClosed){
                if(MyProfileName == 'Partner Community User - Clone - Doctor'){
                    SendEmailConsultationStatusReviewed2.sendEmailToMedic(listIdStrings);
                }/*else if(MyProfileName=='Partner Community User - Clone'){

                }*/
            }
        }
    }
}