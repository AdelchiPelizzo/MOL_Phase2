/**
 * Created by Adelchi on 10/01/2018.
 */

trigger LockRecordIfClosed on Consultation__c (before update) {
    List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
    String MyProfileName = PROFILE[0].Name;
    system.debug('MyProfileName>>> '+ MyProfileName);

    for(Consultation__c newConsultation : Trigger.new){
        Boolean newConsultationIsClosed = newConsultation.status__c.contains('Closed');
        Boolean newConsultationIsLocked = newConsultation.status__c.contains('Locked');
        Consultation__c oldConsultation = Trigger.oldMap.get(newConsultation.Id);
        Boolean oldConsultationIsClosed = oldConsultation.Status__c.contains('Closed');
        Boolean oldConsultationIsLocked = oldConsultation.Status__c.contains('Locked');
        /*system.debug('oldConsultationIsClosed'+oldConsultationIsClosed+'oldConsultationIsLocked'+oldConsultationIsLocked+' oldConsultation.Status__c '+oldConsultation.Status__c);*/
        system.debug('oldConsultation.Status__c >> '+ oldConsultation.Status__c + '  >>> newConsultation.Status__c >> '+newConsultation.Status__c);
        if(oldConsultation.Status__c == 'Closed' && newConsultation.Status__c != 'Closed with Follow up required'){
            newConsultation.addError('Status can be changed only to "Closed with Follow up required" from "Closed" - St0');
        }
        if(MyProfileName=='Partner Community User - Clone - Doctor' && oldConsultation.Status__c == 'In Progress' && newConsultation.Status__c == 'Submitted for Topside supervision Locked'){
            newConsultation.addError('Attempt to change Status from "In progress" to "Submitted for Topside supervision Locked". This is not allowed to a Doctor. - St1');
        }
        if(MyProfileName=='Partner Community User -  Clone' && oldConsultation.Status__c == 'In Progress' && newConsultation.Status__c == 'Topside Reviewed Locked'){
            system.debug('Here is where the error should be triggered ');
            newConsultation.addError('Attempt to change Status from "In progress" to "Topside Reviewed Locked". This is not allowed to a Medic. - St2');
        }
        if(MyProfileName=='Partner Community User - Clone - Doctor' && oldConsultation.Status__c == 'Submitted for Topside supervision Locked' && newConsultation.Status__c == 'In Progress'){
            newConsultation.addError('Attempt to change Status from "Submitted for Topside supervision Locked" to "In Progress". This is not allowed to a Doctor. - St3');
        }
        if(MyProfileName=='Partner Community User -  Clone' && (oldConsultation.Status__c == 'Submitted for Topside supervision Locked' && newConsultation.Status__c == 'Topside Reviewed Locked') ){
            newConsultation.addError('Attempt to change Status from "Submitted for Topside supervision Locked" to "Topside Reviewed Locked". This is not allowed to a Doctor. - St4');
        }
        if(MyProfileName=='Partner Community User - Clone - Doctor' && oldConsultation.Status__c == 'Topside Reviewed Locked' && newConsultation.Status__c == 'In Progress'){
            newConsultation.addError('Attempt to change Status from "Topside Reviewed Locked" to "In Progress". This is not allowed. - St5');
        }
        if(MyProfileName=='Partner Community User - Clone - Doctor' && (oldConsultation.Status__c == 'Closed with Follow up required' && newConsultation.Status__c == 'Submitted for Topside supervision Locked') ){
            newConsultation.addError('Attempt to change Status from "Closed with Follow up required" to "Submitted for Topside supervision Locked". This is not allowed to a Doctor. - St6');
        }
        if(MyProfileName=='Partner Community User -  Clone' && (oldConsultation.Status__c == 'Closed with Follow up required' && newConsultation.Status__c == 'Topside Reviewed Locked') ){
            newConsultation.addError('Attempt to change Status from "Closed with Follow up required" to "Topside Reviewed Locked". This is not allowed to a Medic. - St7');
        }
        if(oldConsultation.Status__c == 'Closed' && newConsultation.Status__c == 'In Progress' || oldConsultation.Status__c == 'Closed' && newConsultation.Status__c == 'Submitted for Topside supervision Locked' || oldConsultation.Status__c == 'Closed' && newConsultation.Status__c == 'Topside Reviewed Locked'){
            newConsultation.addError('Attempt to change Status from "Closed" to "In Progress" or to "Submitted for Topside supervision Locked" or to "Topside Reviewed Locked" . These changes are not allowed after a case is Closed. - St8');
        }else if(oldConsultationIsLocked){
            system.debug('Is this Consultation Locked ? ---->'+oldConsultationIsLocked);
            if(MyProfileName=='Partner Community User - Clone - Doctor'){
                if(
                    newConsultation.Additional_Observations__c != oldConsultation.Additional_Observations__c ||
                    newConsultation.Alcohol_Intake__c != oldConsultation.Alcohol_Intake__c ||
                    newConsultation.Allergies__c != oldConsultation.Allergies__c ||
                    newConsultation.Assessment__c != oldConsultation.Assessment__c ||
                    newConsultation.Background__c != oldConsultation.Background__c ||
                    newConsultation.Batch_Number__c != oldConsultation.Batch_Number__c ||
                    newConsultation.BMI__c != oldConsultation.BMI__c ||
                    newConsultation.BP_Diastolic__c != oldConsultation.BP_Diastolic__c ||
                    newConsultation.BP_Systolic__c != oldConsultation.BP_Systolic__c ||
                    newConsultation.BP_Systolic__c != oldConsultation.BP_Systolic__c ||
                    newConsultation.Category__c != oldConsultation.Category__c ||
                    newConsultation.Client__c != oldConsultation.Client__c ||
                    newConsultation.Consultation_Date__c != oldConsultation.Consultation_Date__c ||
                    newConsultation.Consultation_Details__c != oldConsultation.Consultation_Details__c ||
                    newConsultation.Contact_Work_Location__c != oldConsultation.Contact_Work_Location__c ||
                    newConsultation.Days_on_Site__c != oldConsultation.Days_on_Site__c ||
                    newConsultation.Destination__c != oldConsultation.Destination__c ||
                    newConsultation.Diagnosis_Heading__c != oldConsultation.Diagnosis_Heading__c ||
                    newConsultation.Dispensed_from_FGH__c != oldConsultation.Dispensed_from_FGH__c ||
                    newConsultation.Disposal__c != oldConsultation.Disposal__c ||
                    newConsultation.Expiry_Date__c != oldConsultation.Expiry_Date__c ||
                    newConsultation.Litres__c != oldConsultation.Litres__c ||
                    newConsultation.Medic__c != oldConsultation.Medic__c ||
                    newConsultation.MSO_Formulary__c != oldConsultation.MSO_Formulary__c ||
                    newConsultation.Operator__c != oldConsultation.Operator__c ||
                    newConsultation.Other_Destination__c != oldConsultation.Other_Destination__c ||
                    newConsultation.Outcome_Comment__c != oldConsultation.Outcome_Comment__c ||
                    newConsultation.Shift__c != oldConsultation.Shift__c ||
                    newConsultation.Site__c != oldConsultation.Site__c ||
                    newConsultation.Smoking__c != oldConsultation.Smoking__c ||
                    newConsultation.Situation__c != oldConsultation.Situation__c ||
                    newConsultation.Temperature_Deg_C__c != oldConsultation.Temperature_Deg_C__c ||
                    newConsultation.Topside_Comments__c != oldConsultation.Topside_Comments__c ||
                    /*newConsultation.Topside_Contacted__c != oldConsultation.Topside_Contacted__c ||*/
                    newConsultation.Topside_Doctor__c != oldConsultation.Topside_Doctor__c ||
                    newConsultation.Topside_Suggested_Treatment_Follow_up__c != oldConsultation.Topside_Suggested_Treatment_Follow_up__c ||
                    newConsultation.Top_Side_Appraisal__c != oldConsultation.Top_Side_Appraisal__c ||
                    newConsultation.Treatment__c != oldConsultation.Treatment__c ||
                    newConsultation.Weight_Kg__c != oldConsultation.Weight_Kg__c ||
                    newConsultation.Destination__c != oldConsultation.Destination__c |
                    newConsultation.Disposal__c != oldConsultation.Disposal__c ||
                    newConsultation.Other_Destination__c != oldConsultation.Other_Destination__c ||
                    newConsultation.Outcome__c != oldConsultation.Outcome__c ||
                    newConsultation.Outcome_Comment__c != oldConsultation.Outcome_Comment__c ||
                    newConsultation.Treatment__c != oldConsultation.Treatment__c ||
                    newConsultation.Clinical_Outcome__c != oldConsultation.Clinical_Outcome__c
                    ){ newConsultation.addError('These Fields are Not editable. Record edit has been limited - D1');}
            }else if(MyProfileName=='Partner Community User -  Clone'){
                system.debug('Is this a Partner ? ---->'+MyProfileName);
                if(
                    newConsultation.Additional_Observations__c != oldConsultation.Additional_Observations__c ||
                    newConsultation.Alcohol_Intake__c != oldConsultation.Alcohol_Intake__c ||
                    newConsultation.Allergies__c != oldConsultation.Allergies__c ||
                    newConsultation.Assessment__c != oldConsultation.Assessment__c ||
                    newConsultation.Background__c != oldConsultation.Background__c ||
                    newConsultation.Batch_Number__c != oldConsultation.Batch_Number__c ||
                    newConsultation.BMI__c != oldConsultation.BMI__c ||
                    newConsultation.BP_Diastolic__c != oldConsultation.BP_Diastolic__c ||
                    newConsultation.BP_Systolic__c != oldConsultation.BP_Systolic__c ||
                    newConsultation.BP_Systolic__c != oldConsultation.BP_Systolic__c ||
                    newConsultation.Category__c != oldConsultation.Category__c ||
                    newConsultation.Client__c != oldConsultation.Client__c ||
                    newConsultation.Consultation_Date__c != oldConsultation.Consultation_Date__c ||
                    newConsultation.Consultation_Details__c != oldConsultation.Consultation_Details__c ||
                    newConsultation.Contact_Work_Location__c != oldConsultation.Contact_Work_Location__c ||
                    newConsultation.Days_on_Site__c != oldConsultation.Days_on_Site__c ||
                    newConsultation.Destination__c != oldConsultation.Destination__c ||
                    newConsultation.Diagnosis_Heading__c != oldConsultation.Diagnosis_Heading__c ||
                    newConsultation.Dispensed_from_FGH__c != oldConsultation.Dispensed_from_FGH__c ||
                    newConsultation.Disposal__c != oldConsultation.Disposal__c ||
                    newConsultation.Expiry_Date__c != oldConsultation.Expiry_Date__c ||
                    newConsultation.Litres__c != oldConsultation.Litres__c ||
                    newConsultation.Medic__c != oldConsultation.Medic__c ||
                    newConsultation.MSO_Formulary__c != oldConsultation.MSO_Formulary__c ||
                    newConsultation.Operator__c != oldConsultation.Operator__c ||
                    newConsultation.Other_Destination__c != oldConsultation.Other_Destination__c ||
                    newConsultation.Outcome_Comment__c != oldConsultation.Outcome_Comment__c ||
                    newConsultation.Shift__c != oldConsultation.Shift__c ||
                    newConsultation.Site__c != oldConsultation.Site__c ||
                    newConsultation.Smoking__c != oldConsultation.Smoking__c ||
                    newConsultation.Situation__c != oldConsultation.Situation__c ||
                    /*newConsultation.Status__c != oldConsultation.Status__c ||*/
                    newConsultation.Temperature_Deg_C__c != oldConsultation.Temperature_Deg_C__c ||
                    newConsultation.Topside_Comments__c != oldConsultation.Topside_Comments__c ||
                    /*newConsultation.Topside_Contacted__c != oldConsultation.Topside_Contacted__c ||*/
                    newConsultation.Topside_Doctor__c != oldConsultation.Topside_Doctor__c ||
                    newConsultation.Topside_Suggested_Treatment_Follow_up__c != oldConsultation.Topside_Suggested_Treatment_Follow_up__c ||
                    newConsultation.Top_Side_Appraisal__c != oldConsultation.Top_Side_Appraisal__c ||
                    newConsultation.Treatment__c != oldConsultation.Treatment__c ||
                    newConsultation.Weight_Kg__c != oldConsultation.Weight_Kg__c ||
                    newConsultation.TSDestination__c != oldConsultation.TSDestination__c ||
                    newConsultation.TSDisposal__c != oldConsultation.TSDisposal__c ||
                    newConsultation.TSOtherDestination__c != oldConsultation.TSOtherDestination__c ||
                    newConsultation.TSOutcome__c != oldConsultation.TSOutcome__c ||
                    newConsultation.TSOutcomeComment__c != oldConsultation.TSOutcomeComment__c ||
                    newConsultation.TSTreatment__c != oldConsultation.TSTreatment__c ||
                    newConsultation.TSClinical_Outcome__c != oldConsultation.TSClinical_Outcome__c
                    //Add new Fields to be Locked
                ){ newConsultation.addError('These Fields are Not editable. Record edit has been Locked while submitted for Topside supervision! - M1');}
            }
        }
    }
}