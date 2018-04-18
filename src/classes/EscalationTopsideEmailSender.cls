/**
 * Created by Adelchi on 12/01/2018.
 */

public class EscalationTopsideEmailSender {
    private final Consultation__c consultation;
    public String MedevacAssessmentLocation {get;set;}
    public String PointOfMobilisation {get;set;}
    public String DisembarkationNotificationProcess {get;set;}
    public String IqarusChaperoneServiceRequired {get;set;}
    public String ChaperoneNotificationProcess {get;set;}
    public String communityId;
    public String Id {get;set;}

    public EscalationTopsideEmailSender(ApexPages.StandardController stdController){
        this.consultation = (Consultation__c)stdController.getRecord();
    }

    public ApexPages.Action sendIt (){
        communityId = [SELECT Id FROM Network WHERE Name = 'WebConsultation' LIMIT 1].Id;
        system.debug(communityId);
        Id = System.currentPageReference().getParameters().get('id');
        Consultation__c c = [SELECT Id, Name, Operator__r.Name, Operator__c, Outcome__c, Medic__c, Site__c FROM Consultation__c WHERE Id =: Id];
        List<Site__c> s = [SELECT Id, Name, Medevac_Assessment_location__c, Point_of_mobilisation__c, Disembarkation_notification_Process__c, Iqarus_chaperone_service_required__c, Chaperone_Notification_Process__c,  SickBayPhone__c, SickBayEmail__c FROM Site__c WHERE Id =: c.Site__c];
        if(s.size()>0){
            MedevacAssessmentLocation = s[0].Medevac_Assessment_location__c;
            PointOfMobilisation = s[0].Point_of_mobilisation__c;
            DisembarkationNotificationProcess = s[0].Disembarkation_notification_Process__c;
            IqarusChaperoneServiceRequired = s[0].Iqarus_chaperone_service_required__c;
            ChaperoneNotificationProcess = s[0].Chaperone_Notification_Process__c;
        }
        system.debug(s[0]);
        system.debug(System.currentPageReference().getParameters().get('id'));
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        /*EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Topside_Escalation'];*/
        List<String> recipient = new List<String>();
        User u = [SELECT Email, Name FROM User WHERE Name = 'Top Side' LIMIT 1];
        system.debug(u.Email);
        recipient.add(u.Email);
        system.debug(recipient);
        msg.setToAddresses(recipient);
        msg.setSaveAsActivity(False);
        String site = s[0].Name;
        msg.setSubject('Topside Escalation : '+c.Operator__r.Name+' - '+site+' - '+c.Outcome__c);
        String urlString = URL.getSalesforceBaseUrl().toExternalForm()+'/WebConsultation/s/consultation/'+c.Id+'/cl0000014';
        system.debug(urlString);
        String linkToRecord = '<a href="'+urlString+'">'+c.Name+'</a>';
        system.debug(linkToRecord);
        String Phone = s[0].SickBayPhone__c;
        String Email = s[0].SickBayEmail__c;
        String medic = c.Medic__c;
        msg.setHtmlBody('<html><body><h2>Dear Topside Doctor</h2></br></br>' +
                '<p>Please be aware that Consultation  '+linkToRecord+' has been escalated for you to review.</p></br></br>' +
                '<p>This was escalated by:  </br><strong>'+medic+'</strong></br><p> Phone :' +Phone+'</p><p>Email : '+Email+'</p></body></html>');
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {msg});
        system.debug(r);
        consultation.Status__c = 'Submitted for Topside supervision Locked';
        EmailMessage emailMsg = new EmailMessage();
        emailMsg.Subject = 'Subject : '+'Topside Escalation : '+c.Operator__r.Name+' - '+site+' - '+c.Outcome__c;
        emailMsg.TextBody = 'Dear Topside Doctor Please be aware that Consultation  '+c.Name+' has been escalated for you to review. This was escalated by: '+medic+'  Phone :' +Phone+' Email : '+Email;
        emailMsg.FromName = medic;
        emailMsg.MessageDate = datetime.now();
        emailMsg.Email__c = Id;
        insert emailMsg;
        update consultation;
        return null;
    }



}