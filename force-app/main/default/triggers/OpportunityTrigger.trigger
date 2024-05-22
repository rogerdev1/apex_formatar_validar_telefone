trigger OpportunityTrigger on Opportunity (before insert, before update) {

    if (trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        OpportunityTriggerHandler.validarFormatoTelefone(Trigger.new);
    }
    // for (Opportunity opp : Trigger.new) {
    //     if (String.isBlank(OPP.CNPJ__c)) {
    //         opp.addError('CNPJ VAZIO');
    //         OpportunityTriggerHandler.showModal();
    //     }
    // }
}