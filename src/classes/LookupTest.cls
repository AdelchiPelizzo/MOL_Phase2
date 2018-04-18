/**
 * Created by Adelchi on 09/02/2018.
 */

@IsTest
private class LookupTest {
    public static Account a;
    public static void generateTestData(){
        a = new Account(
                Status__c = 'Active',
                Name = 'testAccount'
        );
        insert a;
    }
    static testMethod void testBehavior () {
        generateTestData();
        test.startTest();
        String accountsList = Lookup.searchDB('Account','Name','Id',1,'Name','testAccount');
        system.assertEquals('[{"val":"'+a.Id+'","text":"'+a.Name+'","objName":"Account"}]',accountsList);
        test.stopTest();

    }
}