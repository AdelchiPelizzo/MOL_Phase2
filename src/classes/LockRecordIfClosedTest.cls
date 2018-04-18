/**
 * Created by Adelchi on 12/02/2018.
 */

@IsTest
private class LockRecordIfClosedTest {

    public static Account a ;
    public static Account a2 ;
    public static Consultation__c cNewClosed;
    public static Consultation__c cOldClosed;
    public static Consultation__c cNewLocked;
    public static Consultation__c cOldLocked;
    public static Site__c s;
    public static Site__c s2;
    public static User uD;
    public static User u;
    public static Profile profileIdD;
    public static Profile profileId;
    public static Contact contD;
    public static Contact cont;

    public static void generateTestData(){
        RecordType recType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Consult_Patient' LIMIT 1];
        a = new Account(
                Status__c = 'Active',
                Name = 'testAccount'
        );
        insert a;

        a2 = new Account(
                Status__c = 'Active',
                Name = 'testAccount2'
        );
        insert a2;
        contD = new Contact(
                FirstName = 'Test',
                RecordTypeId = recType.Id,
                LastName = 'testLastNameD',
                AccountId = a.Id,
                Birthdate = date.newInstance(2000,1,1),
                GDPRCompliant__c = True,
                Gender__c = 'Male',
                OccupationCategory__c = 'Operations Administration',
                OccupationTitle__c = 'Medic'
        );
        insert contD;
        cont = new Contact(
                FirstName = 'Test',
                RecordTypeId = recType.Id,
                LastName = 'testLastName',
                AccountId = a.Id,
                Birthdate = date.newInstance(2000,1,1),
                GDPRCompliant__c = True,
                Gender__c = 'Male',
                OccupationCategory__c = 'Operations Administration',
                OccupationTitle__c = 'Medic'
        );
        insert cont;
        s = new Site__c(
                Name = 'testSite',
                Account__c = a.Id,
                Site_Type__c = 'Office',
                Clinic_Code__c = 'testClinicCode',
                SAP_Customer_ID__c = 'testNAVId'
        );
        insert s;
        s2 = new Site__c(
                Name = 'testSite',
                Account__c = a.Id,
                Site_Type__c = 'Office',
                Clinic_Code__c = 'testClinicCode',
                SAP_Customer_ID__c = 'testNAVId'
        );
        insert s2;
        system.debug(s.Name);
        cOldClosed = new Consultation__c(
                Status__c = 'Closed',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02),
                Alcohol_Intake__c = '0 Units per week',
                Allergies__c = 'Allergies__c',
                Assessment__c = 'Assessment__c',
                Background__c = 'Background__c',
                Batch_Number__c = 'Batch_Number__c',
                /*BMI__c = 'BMI__c',*/
                BP_Diastolic__c = 1,
                BP_Systolic__c = 1,
                Category__c = 'Injury',
                Client__c = cont.Id,
                Consultation_Date__c = date.newInstance(2018,01,02),
                Consultation_Details__c = 'Consultation_Details__c',
                Contact_Work_Location__c = 'Contact_Work_Location__c',
                Days_on_Site__c = 2,
                Destination__c = '',
                /*Diagnosis_Heading__c = 'D - DIGESTIVE',*/
                Dispensed_from_FGH__c = true,
                Expiry_Date__c = date.newInstance(2018,01,02),
                Litres__c = 1,
                /*Medic__c = 'Medic__c',*/
                MSO_Formulary__c = 'MSO_Formulary__c',
                Smoking__c = 'Never',
                Situation__c = 'Situation__c',
                /*Status__c = 'Status__c',*/
                Temperature_Deg_C__c = 1,
                Topside_Comments__c = 'Topside_Comments__c',
                /*Topside_Contacted__c = 'Topside_Contacted__c',*/
                Topside_Suggested_Treatment_Follow_up__c = 'Topside_Suggested_Treatment_Follow_up__c',
                Top_Side_Appraisal__c = 1,
                Treatment__c = 'Treatment__c',
                Weight_Kg__c = 1,
                Other_Destination__c = 'Other_Destination__c',
                Outcome__c = 'Work Related',
                Outcome_Comment__c = 'Outcome_Comment__c',
                Clinical_Outcome__c = 'Dental',
                Additional_Observations__c = 'additionalObservationTest'
        );
        insert cOldClosed;
        cNewClosed = new Consultation__c(
                Status__c = 'Closed',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02),
                Alcohol_Intake__c = '0 Units per week',
                Allergies__c = 'Allergies__c',
                Assessment__c = 'Assessment__c',
                Background__c = 'Background__c',
                Batch_Number__c = 'Batch_Number__c',
                /*BMI__c = 'BMI__c',*/
                BP_Diastolic__c = 1,
                BP_Systolic__c = 1,
                Category__c = 'Injury',
                Client__c = cont.Id,
                Consultation_Date__c = date.newInstance(2018,01,02),
                Consultation_Details__c = 'Consultation_Details__c',
                Contact_Work_Location__c = 'Contact_Work_Location__c',
                Days_on_Site__c = 2,
                Destination__c = 'Iqarus Aberdeen',
                Diagnosis_Heading__c = 'Diagnosis_Heading__c',
                Dispensed_from_FGH__c = true,
                Expiry_Date__c = date.newInstance(2018,01,02),
                Litres__c = 1,
                /*Medic__c = 'Medic__c',*/
                MSO_Formulary__c = 'MSO_Formulary__c',
                Smoking__c = 'Never',
                Situation__c = 'Situation__c',
                /*Status__c = 'Status__c',*/
                Temperature_Deg_C__c = 1,
                Topside_Comments__c = 'Topside_Comments__c',
                /*Topside_Contacted__c = 'Topside_Contacted__c',*/
                Topside_Doctor__c = contD.Id,
                Topside_Suggested_Treatment_Follow_up__c = 'Topside_Suggested_Treatment_Follow_up__c',
                Top_Side_Appraisal__c = 1,
                Treatment__c = 'Treatment__c',
                Weight_Kg__c = 1,
                Other_Destination__c = 'Other_Destination__c',
                Outcome__c = 'Work Related',
                Outcome_Comment__c = 'Outcome_Comment__c',
                Clinical_Outcome__c = 'Dental',
                Additional_Observations__c = 'additionalObservationTest'
        );
        cOldLocked = new Consultation__c(
                Status__c = 'Topside Reviewed Locked',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                TSDisposal__c = '',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02),
                Alcohol_Intake__c = '0 Units per week',
                Allergies__c = 'Allergies__c',
                Assessment__c = 'Assessment__c',
                Background__c = 'Background__c',
                Batch_Number__c = 'Batch_Number__c',
                /*BMI__c = 'BMI__c',*/
                BP_Diastolic__c = 1,
                BP_Systolic__c = 1,
                Category__c = 'Injury',
                Client__c = cont.Id,
                Consultation_Date__c = date.newInstance(2018,01,02),
                Consultation_Details__c = 'Consultation_Details__c',
                Contact_Work_Location__c = 'Contact_Work_Location__c',
                Days_on_Site__c = 2,
                /*Destination__c = 'Iqarus Aberdeen',*/
                /*Diagnosis_Heading__c = 'Diagnosis_Heading__c',*/
                Dispensed_from_FGH__c = true,
                Expiry_Date__c = date.newInstance(2018,01,02),
                Litres__c = 1,
                /*Medic__c = 'Medic__c',*/
                MSO_Formulary__c = 'MSO_Formulary__c',
                Smoking__c = 'Never',
                Situation__c = 'Situation__c',
                /*Status__c = 'Status__c',*/
                Temperature_Deg_C__c = 1,
                Topside_Comments__c = 'Topside_Comments__c',
                /*Topside_Contacted__c = 'Topside_Contacted__c',*/
                /*Topside_Doctor__c = contD.Id,*/
                Topside_Suggested_Treatment_Follow_up__c = 'Topside_Suggested_Treatment_Follow_up__c',
                Top_Side_Appraisal__c = 1,
                Treatment__c = 'Treatment__c',
                Weight_Kg__c = 1,
                Other_Destination__c = 'Other_Destination__c',
                Outcome__c = 'Work Related',
                Outcome_Comment__c = 'Outcome_Comment__c',
                Clinical_Outcome__c = 'Dental',
                Additional_Observations__c = 'additionalObservationTest'
        );
        insert cOldLocked;
        cNewLocked = new Consultation__c(
                Status__c = 'Topside Reviewed Locked',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02),
                Alcohol_Intake__c = '0 Units per week',
                Allergies__c = 'Allergies__c',
                Assessment__c = 'Assessment__c',
                Background__c = 'Background__c',
                Batch_Number__c = 'Batch_Number__c',
                /*BMI__c = 'BMI__c',*/
                BP_Diastolic__c = 1,
                BP_Systolic__c = 1,
                Category__c = 'Injury',
                Client__c = cont.Id,
                Consultation_Date__c = date.newInstance(2018,01,02),
                Consultation_Details__c = 'Consultation_Details__c',
                Contact_Work_Location__c = 'Contact_Work_Location__c',
                Days_on_Site__c = 2,
                /*Destination__c = 'Iqarus Aberdeen',*/
                /*Diagnosis_Heading__c = 'Diagnosis_Heading__c',*/
                Dispensed_from_FGH__c = true,
                Expiry_Date__c = date.newInstance(2018,01,02),
                Litres__c = 1,
                /*Medic__c = 'Medic__c',*/
                MSO_Formulary__c = 'MSO_Formulary__c',
                Smoking__c = 'Never',
                Situation__c = 'Situation__c',
                /*Status__c = 'Status__c',*/
                Temperature_Deg_C__c = 1,
                Topside_Comments__c = 'Topside_Comments__c',
                /*Topside_Contacted__c = 'Topside_Contacted__c',*/
                /*Topside_Doctor__c = contD.Id,*/
                Topside_Suggested_Treatment_Follow_up__c = 'Topside_Suggested_Treatment_Follow_up__c',
                Top_Side_Appraisal__c = 1,
                Treatment__c = 'Treatment__c',
                Weight_Kg__c = 1,
                Other_Destination__c = 'Other_Destination__c',
                Outcome__c = 'Work Related',
                Outcome_Comment__c = 'Outcome_Comment__c',
                Clinical_Outcome__c = 'Dental',
                Additional_Observations__c = 'additionalObservationTest'
        );
        insert cNewLocked;
        String siteId = cNewClosed.Site__c;
        String siteName = [SELECT Name FROM Site__c WHERE Id =: siteId LIMIT 1].Name;
        Profile pD = [SELECT Id FROM Profile WHERE Name = 'Partner Community User - Clone - Doctor' LIMIT 1];
        uD = new User(
                LastName = 'LastD',
                FirstName='JamesD',
                Alias = 'jlasD',
                Email = 'test@test.testD',
                Username = 'test@iqarus.iqarusD',
                ProfileId = pD.Id,
                TimeZoneSidKey = 'GMT',
                LanguageLocaleKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LocaleSidKey = 'en_US',
                ContactId = contD.Id
        );
        insert uD;
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Partner Community User -  Clone' LIMIT 1];
        u = new User(
                LastName = 'Last',
                FirstName='James',
                Alias = 'jlas',
                Email = 'test@test.test',
                Username = 'test@iqarus.iqarus',
                ProfileId = p.Id,
                TimeZoneSidKey = 'GMT',
                LanguageLocaleKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                LocaleSidKey = 'en_US',
                ContactId = cont.Id
        );
        insert u;
    }

    static testMethod void testBehavior () {
        generateTestData();
        Boolean result;
        system.runAs(uD){
            system.debug(uD);
            try{
                /*cOldClosed.Alcohol_Intake__c='< 14 Units per week';
                cOldClosed.Allergies__c='x';
                cOldClosed.Assessment__c='x';
                cOldClosed.Background__c='x';
                cOldClosed.Batch_Number__c='x';
                cOldClosed.BP_Diastolic__c=2;
                cOldClosed.BP_Systolic__c=2;
                cOldClosed.Category__c='Illness';
                cOldClosed.Client__c=cont.Id;
                cOldClosed.Consultation_Date__c=date.newInstance(2018,01,01);
                cOldClosed.Consultation_Details__c='x';
                cOldClosed.Contact_Work_Location__c='x';
                cOldClosed.Days_on_Site__c=2;
                cOldClosed.Destination__c='A+E';
                cOldClosed.Diagnosis_Heading__c='F - EYE';
                cOldClosed.Dispensed_from_FGH__c=False;
                cOldClosed.Disposal__c='Fit to work';
                cOldClosed.Expiry_Date__c = date.newInstance(2018,01,01);
                cOldClosed.Litres__c=3;
                cOldClosed.MSO_Formulary__c='x';
                cOldClosed.Operator__c=a2.Id;
                cOldClosed.Other_Destination__c='x';
                cOldClosed.Outcome_Comment__c='x';
                cOldClosed.Shift__c='x';
                cOldClosed.Site__c=s.Id;
                cOldClosed.Smoking__c='Current';
                cOldClosed.Situation__c='x';
Status__c*/
                cOldClosed.Temperature_Deg_C__c= 5;
                cOldClosed.Topside_Comments__c='x';
/*Topside_Contacted__c*/
                /*cOldClosed.Topside_Doctor__c='x';*/
                cOldClosed.Topside_Suggested_Treatment_Follow_up__c='x';
                cOldClosed.Top_Side_Appraisal__c=5;
                cOldClosed.Treatment__c='x';
                cOldClosed.Weight_Kg__c=100;
                cOldClosed.Destination__c='x';
                cOldClosed.Disposal__c='x';
                cOldClosed.Other_Destination__c='x';
                cOldClosed.Outcome__c='x';
                cOldClosed.Outcome_Comment__c='x';
                cOldClosed.Treatment__c='x';
                cOldClosed.Clinical_Outcome__c='x';
                cOldClosed.Additional_Observations__c='x';
                update cOldClosed;
            }catch(DmlException ex){
                result = false;
                system.debug(ex);
            }
            system.assertEquals(result, false);
            result = true;
            try{
                cOldLocked.TSDisposal__c = 'Optivac';
                cOldLocked.Alcohol_Intake__c = '0 Units per week';
                cOldLocked.Allergies__c = 'Allergies__c';
                cOldLocked.Assessment__c = 'Assessment__c';
                cOldLocked.Background__c = 'Background__c';
                cOldLocked.Batch_Number__c = 'Batch_Number__c';
                update cOldLocked;
            }catch(DmlException ex){
                result = false;
                system.debug(ex);
            }
            system.assertEquals(result, true);
            try{
                cNewLocked.TSDisposal__c = 'Optivac';
                update cNewLocked;
            }catch(DmlException ex){
                result = false;
                system.debug(ex);
            }
            system.assertEquals(result, true);
        }
        system.runAs(u){
            system.debug(u);
            cOldLocked.Additional_Observations__c = 'additionalObservationTestChanged';
            try{
                update cOldLocked;
            }catch(DmlException ex){
                result = false;
                system.debug(ex);
            }
            system.assertEquals(result, false);
            cOldLocked.Additional_Observations__c = 'additionalObservationTest';
            cOldLocked.Disposal__c = 'Optivac';
            try{
                update cOldLocked;
            }catch(DmlException ex){
                result = false;
                system.debug(ex);
            }
            system.assertEquals(result, false);
        }

    }
}