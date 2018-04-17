/**
 * Created by Adelchi on 19/12/2017.......
 */

public with sharing class ContactSearchCtrl {
    @AuraEnabled
    public static List<Contact> searchForContacts(String searchText, String searchDate) {
        List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userInfo.getProfileId() LIMIT 1];
        User userUser = [SELECT ContactId FROM User WHERE Id =: userInfo.getUserId() LIMIT 1];
        String MyProfileName = PROFILE[0].Name;
        Contact userContact = [SELECT AccountId FROM Contact WHERE Id =: userUser.ContactId LIMIT 1];
        String AccountIdString = userContact.AccountId;
        system.debug('text >>> '+searchText);
        system.debug('date >>> '+searchDate);
        Integer intYear;
        Integer intMonth;
        Integer intDay;
        if(searchDate!=null&&searchDate!=''){
                List<String> dateStr = searchDate.split('-');
                List<Integer> dateInt = new List<Integer>();
                intYear = Integer.valueOf(dateStr[0]);
                system.debug(intYear);
                intMonth = Integer.valueOf(dateStr[1]);
                intDay = Integer.valueOf(dateStr[2]);
            }
        List<Contact> contactList = new List<Contact>();
        List<Contact> contactListx = new List<Contact>();
        String query = 'SELECT Account.Name, OccupationTitle__c, Name, firstName, lastName, Age__c, Gender__c, Birthdate, CreatedDate FROM Contact WHERE RecordType.DeveloperName = \'Consult_Patient\' LIMIT 10';
        String query1 = 'SELECT Account.Name, OccupationTitle__c, Title, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE Name LIKE \'%'+ searchText + '%\' AND RecordType.DeveloperName = \'Consult_Patient\' ORDER by lastName ASC LIMIT 10 ';
        String query2 = 'SELECT Account.Name, OccupationTitle__c, Title, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE  CALENDAR_YEAR(Birthdate) >= '+intYear+  ' AND CALENDAR_MONTH(Birthdate) >= '+intMonth+' AND DAY_IN_MONTH(Birthdate) >= '+intDay+' AND RecordType.DeveloperName = \'Consult_Patient\' ORDER by BirthDate ASC LIMIT 10 ';
        String query3 = 'SELECT Account.Name, OccupationTitle__c, Title, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE Name LIKE \'%'+ searchText + '%\' AND  CALENDAR_YEAR(Birthdate) >= '+intYear+  ' AND CALENDAR_MONTH(Birthdate) >= '+intMonth+' AND DAY_IN_MONTH(Birthdate) >= '+intDay+' AND RecordType.DeveloperName = \'Consult_Patient\' ORDER by lastName ASC LIMIT 10 ';

        String queryx = 'SELECT Account.Name, OccupationTitle__c, Name, firstName, lastName, Age__c, Gender__c, Birthdate, CreatedDate FROM Contact WHERE RecordType.DeveloperName = \'Consult_Patient\' AND AccountId = \''+AccountIdString+'\' LIMIT 10';
        String query1x = 'SELECT Account.Name, OccupationTitle__c, Title, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE Name LIKE \'%'+ searchText + '%\' AND RecordType.DeveloperName = \'Consult_Patient\' AND AccountId = \''+AccountIdString+'\' ORDER by lastName ASC LIMIT 10 ';
        String query2x = 'SELECT Account.Name, OccupationTitle__c, Title, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE  CALENDAR_YEAR(Birthdate) >= '+intYear+  ' AND CALENDAR_MONTH(Birthdate) >= '+intMonth+' AND DAY_IN_MONTH(Birthdate) >= '+intDay+' AND RecordType.DeveloperName = \'Consult_Patient\' AND AccountId = \''+AccountIdString+'\' ORDER by BirthDate ASC LIMIT 10 ';
        String query3x = 'SELECT Account.Name, OccupationTitle__c, Title, Name, firstName, lastName, Age__c, Gender__c, Birthdate FROM Contact WHERE Name LIKE \'%'+ searchText + '%\' AND  CALENDAR_YEAR(Birthdate) >= '+intYear+  ' AND CALENDAR_MONTH(Birthdate) >= '+intMonth+' AND DAY_IN_MONTH(Birthdate) >= '+intDay+' AND RecordType.DeveloperName = \'Consult_Patient\' AND AccountId = \''+AccountIdString+'\' ORDER by lastName ASC LIMIT 10 ';


        contactList = [SELECT Account.Name, OccupationTitle__c, Name, firstName, lastName, Age__c, Gender__c, Birthdate, CreatedDate FROM Contact WHERE RecordType.DeveloperName = 'Consult_Patient' ORDER BY LastModifiedDate DESC LIMIT 10];
        contactListx = [SELECT Account.Name, OccupationTitle__c, Name, firstName, lastName, Age__c, Gender__c, Birthdate, CreatedDate FROM Contact WHERE RecordType.DeveloperName = 'Consult_Patient' AND AccountId =:AccountIdString ORDER BY LastModifiedDate DESC LIMIT 10];


        if(myProfileName == 'Customer Community Login Medic') {
            if (searchText != null && searchDate == null) {
                system.debug('run query 1x');
                contactList = Database.query(query1x);
                return contactList;
            } else if (searchText == null && searchDate != null) {
                system.debug('run query 2x');
                contactList = Database.query(query2x);
                return contactList;
            } else if ((searchText != null && searchDate != null) || (searchText != null && searchDate != '')) {
                system.debug('run query 3x');
                contactList = Database.query(query3x);
                return contactList;
            } else {
                contactList = Database.query(queryx);
                return contactListx;
            }
        }else{
            if(searchText!=null && searchDate == null){
                system.debug('run query 1');
                contactList = Database.query(query1);
                return contactList;
            }else if(searchText==null && searchDate!=null){
                system.debug('run query 2');
                contactList = Database.query(query2);
                return contactList;
            }else if((searchText!=null && searchDate!=null)||(searchText!=null &&searchDate!='')){
                system.debug('run query 3');
                contactList = Database.query(query3);
                return contactList;
            }else{
                contactList = Database.query(query);
                return contactList;
            }

        }
    }
}