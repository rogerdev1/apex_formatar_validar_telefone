public with sharing class OpportunityService {
    public static String formatarTelefone(String numeroTelefone) {
        if (String.isBlank(numeroTelefone)) {
            return numeroTelefone;
        }
        
        numeroTelefone = numeroTelefone.replaceAll('\\s+', '').replaceAll('[^0-9]', '');
        numeroTelefone = numeroTelefone.replaceFirst('^0', '');

        if (!String.isBlank(numeroTelefone)) {

            if (numeroTelefone.length() == 12 && numeroTelefone.startsWith('55')) {
                numeroTelefone = '55 ' + '(' + (numeroTelefone.length() >= 4 ? numeroTelefone.substring(2,4) : '' ) + ') ' + (numeroTelefone.length() >= 9 ? numeroTelefone.substring(4, 8) : '') + '-' + (numeroTelefone.length() >= 12 ? numeroTelefone.substring(8, 12) : '');
                return numeroTelefone;
            } else if (numeroTelefone.length() == 10 && !numeroTelefone.startsWith('55')) {
                numeroTelefone = '(' + (numeroTelefone.length() >= 2 ? numeroTelefone.substring(0, 2) : '' ) + ') ' + (numeroTelefone.length() >= 4 ? numeroTelefone.substring(2, 6) : '') + '-' + (numeroTelefone.length() >= 10 ? numeroTelefone.substring(6, 10) : '');
                numeroTelefone = '55 ' + numeroTelefone;
                return numeroTelefone;
            }

            if (numeroTelefone.length() > 12 && numeroTelefone.startsWith('55')){
                numeroTelefone = '55 ' + '(' + (numeroTelefone.length() >= 4 ? numeroTelefone.substring(2, 4) : '' ) + ') ' + (numeroTelefone.length() >= 9 ? numeroTelefone.substring(4, 9) : '') + '-' + (numeroTelefone.length() >= 12 ? numeroTelefone.substring(9, 13) : '');
                return numeroTelefone;
            } else if (numeroTelefone.length() == 11 && !numeroTelefone.startsWith('55')) {
                numeroTelefone = ' (' + (numeroTelefone.length() >= 2 ? numeroTelefone.substring(0,2) : '' ) + ') ' + (numeroTelefone.length() >= 7 ? numeroTelefone.substring(2, 7) : '') + '-' + (numeroTelefone.length() >= 10 ? numeroTelefone.substring(7, 11) : '');
                numeroTelefone = '55' + numeroTelefone;
                return numeroTelefone;
            }
        }
        return numeroTelefone;
    }

    public static String formatoTelefone2(String numeroTelefone){

        if (String.isBlank(numeroTelefone)) {
            return numeroTelefone;
        }
        
        numeroTelefone = numeroTelefone.replaceAll('\\s+', '').replaceAll('[^0-9]', '');
        numeroTelefone = numeroTelefone.replaceFirst('^0', '');

        List<String> telefoneCom55 = New List<String>{
                                                numeroTelefone.substring(0,2), // DDI
                                                numeroTelefone.substring(2, 4), // DDD
                                                numeroTelefone.substring(4, 8), // Primeira parte com 4 dígitos
                                                numeroTelefone.substring(8) // Segunda parte
        };
        List<String> telefoneSem55 = New List<String>{
                                                numeroTelefone.substring(0,2), // DDD
                                                numeroTelefone.substring(2, 6),  // Primeira parte com 4 dígitos
                                                numeroTelefone.substring(6) // Segunda parte
        };

        String templateCom55 = '{0} ({1}) {2}-{3}';
        String templateSem55 = '({0}) {1}-{2}';

        if (!String.isBlank(numeroTelefone)) {
            if (numeroTelefone.startsWith('55')) {
                numeroTelefone = String.format(templateCom55, telefoneCom55);
                return numeroTelefone;
            }   

            if (!numeroTelefone.startsWith('55')) {
                numeroTelefone = '55 ' + String.format(templateSem55, telefoneSem55);
                return numeroTelefone;
            }
            // retorna com 8 dígitos: 55 (XX) XXXX-XXXX 
        }

        return numeroTelefone;
    }
}