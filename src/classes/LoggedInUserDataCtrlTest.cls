/**
 * Created by Adelchi on 02/04/2018.
 */

@IsTest
private class LoggedInUserDataCtrlTest {
    static testMethod void testBehavior () {
        Test.startTest();
        system.assertEquals(LoggedInUserDataCtrl.getUserName(),userInfo.getName());
        Test.stopTest();
    }
}