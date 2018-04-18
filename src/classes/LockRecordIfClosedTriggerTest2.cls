/**
 * Created by Adelchi on 15/03/2018.
 */

@IsTest
private class LockRecordIfClosedTriggerTest2 {

    public static Account a ;
    public static Consultation__c cNewClosed;
    public static Consultation__c cOldClosed;
    public static Consultation__c cNewLocked;
    public static Consultation__c cOldLocked;
    public static Site__c s;
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
        system.debug(s.Name);
        cOldClosed = new Consultation__c(
                Status__c = 'Closed',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02),
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
                Additional_Observations__c = ''
        );
        cOldLocked = new Consultation__c(
                Status__c = 'Topside Reviewed Locked',
                shift__c = 'Day',
                Disposal__c = 'Advice Only',
                TSDisposal__c = '',
                Operator__c = a.Id,
                Site__c = s.Id,
                CreatedDate = datetime.newInstance(2018,01,02),
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
                Additional_Observations__c = ' '
        );
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
    }

    static testMethod void testBehavior () {
        generateTestData();
        Boolean result;
        insert uD;
        system.runAs(uD){
            system.debug(uD);
            try{
                update cOldClosed;
            }catch(DmlException ex){
                result = false;
                system.debug(ex);
            }
            system.assertEquals(result, false);
            result = true;
            try{
                cOldLocked.TSDisposal__c = 'Optivac';
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
            system.assertEquals(result, false);
        }
        insert u;
        system.runAs(u){
            system.debug(u);
            try{
                update cOldClosed;
            }catch(DmlException ex){
                result = false;
                system.debug(ex);
            }
            system.assertEquals(result, false);
            result = true;
            try{
                cOldLocked.TSDisposal__c = 'Optivac';
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
            system.assertEquals(result, false);
        }

    }
}