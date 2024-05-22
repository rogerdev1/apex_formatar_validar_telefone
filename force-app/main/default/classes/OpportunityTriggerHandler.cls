public class OpportunityTriggerHandler {
    
    public static void validarFormatoTelefone(List<Opportunity> newOpportunities) {
        for (Opportunity opp : newOpportunities) {

            String numeroFormatado = OpportunityService.formatarTelefone(opp.Telefone__c);
            if (!String.isBlank(opp.Telefone__c)) {

                List<String> dddsBR = new List<String>{
                    '11','12','13','14','15','16','17','18','19','21','22', '24','27','28',
                    '31','32','33', '34','35','37','38','41','42','43','44','45','46','47',
                    '48','49','51','53','54','55','61','62','63','64','65','66','67','68',
                    '69','71','73','74','75','77','79','81','82','83','84','85','86','87',
                    '88','89','91','92','93','94','95','96','97','98','99'
                };
            
                if (numeroFormatado != null) {
                    opp.Telefone__c = numeroFormatado;
                    if (opp.Telefone__c.length() < 10) {
                        opp.addError('Número sem DDD');
                    }

                    if (!dddsBR.contains(opp.Telefone__c.substring(4, 6))) {
                        opp.addError('DDD Inválido');
                    }
                                     
                    if(opp.Telefone__c.length() < 10) {
                        opp.addError('Verifique o DDD e a quantidade de digitos do número');
                    }
                } else {
                    opp.addError('Telefone inválido. Exemplo: "+552212345678" ou "+5522123456789"');
                }
            }
        }
    }
}
