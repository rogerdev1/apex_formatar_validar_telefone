# Validação de Campos no Salesforce: O Poder das Máscaras de Entrada.

<p style='text-align: justify;'>
O uso de máscaras em Campos, especialmente em formulários que lidam com dados relevantes como telefone ou CPF, é crucial para garantir a consistência dos dados inseridos. As máscaras ajudam a formatar a entrada do usuário, facilitando a validação e processamento dos dados e fornecendo um feedback visual sobre o formato correto desse dados.
Vou destacar como o código fornecido contribui para essa funcionalidade no <b>Campo Telefone</b>.
</p>

<figure>
    <img src='https://media.licdn.com/dms/image/D4D12AQGtlG_bMg6Rqg/article-inline_image-shrink_1500_2232/0/1716322019055?e=1721865600&v=beta&t=_8agDf3bOa8k-Gk_YPTwYnWQ7KM93ffl9p5Z_b1MogU'>
    <figcaption style='font-size: 12px; color: gray; text-align: center;'>
        Classe Service com método de formatação de telefone.
    </figcaption>
</figure>

#

### Remova espaços e carácteres não desejados

    // para remover todos os espaços em branco
    numeroTelefone = numeroTelefone.replaceAll('\\s+', '');

    // para remover todos os carácteres não numéricos
    numeroTelefone = numeroTelefone.replaceAll('[^0-9]', '');

    // para remover o Zero no início da entrada
    numeroTelefone = numeroTelefone.replaceFirst('^0', '');

<p style='text-align: justify;'>
    Use Expressões Regulares para auxiliar na formatação. São ótimas para garantir que o dado seja processável e conforme o padrão esperado.
</p>

### Formatação com ou sem DDI

<figure>
    <img src='https://media.licdn.com/dms/image/D4D12AQFH7IBSRi2oDw/article-inline_image-shrink_1000_1488/0/1716302387746?e=1721865600&v=beta&t=kPKufCG_YbLRvPAaAerBH6hFvRuXF0nQdWRTK-OC5ow'>
    <figcaption style='font-size: 12px; color: gray; text-align: center;'>
        Exemplo de código com DDI para celulares e fixos.
    </figcaption>
</figure>
<p style='text-align: justify;'>
    Este código verifica se o número já inclui o DDI do país ‘55’. Se sim, aplica a máscara adequada para celulares (9 dígitos) e fixos (8 dígitos) com a função substring(), garantindo que o número seja formatado corretamente.
</p>

> <p style='text-align: justify; padding: 10px'> O método substring() é uma função de manipulação de strings disponível em várias linguagens de programação. Ele é utilizado para extrair uma parte específica de uma string, com base nas posições de índice que você fornecer.
</p>

    string.substring(startIndex, endIndex);

<p style='text-align: justify;'>
    Outra maneira muito interessante de construir este código é usando a função <b>String.format()</b> onde ela recebe argumentos sendo o primeiro, obrigatoriamente, uma String definindo como será o template retornado utilizando marcadores de <b>posição {n}</b>, onde n é o índice do argumento que você deseja inserir. Os demais argumentos, podendo ser um ou vários, são as partes que se moldaram ao template definido.
</p>

    String template = 'Olá, {0}! Você tem {1} novas mensagens.';
    List<Object> args = new List<Object>{'João', 5};
    String formattedString = String.format(template, args);
    System.debug(formattedString); // Saída: "Olá, João! Você tem 5 novas mensagens."


Vamos ver como usamos este método, na prática:

    String templateCom55 = '{0} ({1}) {2}-{3}';
    String templateSem55 = '({0}) {1}-{2}';

<p style='text-align: justify;'>
    Declaro duas variáveis do tipo String para definir os templates com ou sem DDI. A variável templateCom55 recebe o template '{0} ({1}) {2}-{3}' sendo 0 para DDI, <b>1</b> para DDD dentro de parênteses, <b>2</b> para a primeira parte do número, <b>-</b> para divisão das partes e <b>3</b> para a segunda parte do número. 
</p>
<p style='text-align: justify;'>
    A variável templateSem55 segue a mesma ideia sem índice para DDI pensando que o DDI não será inserido pelo usuário.
</p>

<figure>
    <img src='https://media.licdn.com/dms/image/D4D12AQGt_1GpuNfgug/article-inline_image-shrink_1500_2232/0/1716309530338?e=1721865600&v=beta&t=qpWn1jNq3Muv4cy37gcjaaD90i4i-ZpPvLAf0SeU_Tg'>
    <figcaption style='font-size: 12px; color: gray; text-align: center;'>
       Declaração de Lista de Strings.
    </figcaption>
</figure>

<p style='text-align: justify;'>
    Aqui declaro duas Listas de String, uma com e outra sem DDI, para serem usados nos argumentos da função String.format() definindo índices para cada parte do número de telefone.
</p>

<figure>
    <img src='https://media.licdn.com/dms/image/D4D12AQG1bRTjbjhLbA/article-inline_image-shrink_1500_2232/0/1716321084107?e=1721865600&v=beta&t=t_rBEIsAAWptOuyWYQHisu-W0IhUMLijHOncfbmdiNM'>
    <figcaption style='font-size: 12px; color: gray; text-align: center;'>
       Uso da função String.format() na prática.
    </figcaption>
</figure>

<p style='text-align: justify;'>
    É importante usar condicionais que verifiquem se a entrada contém ou não DDI no seu início para que se tenha o retorno correto. A função String.format() recebe, como primeiro parâmetro, o template e, como segundo parâmetro, a Lista de Strings para que cada item componha os argumentos necessários.
</p>

### Valide a entrada e evite erros

<p style='text-align: justify;'>
    Uma boa validação de entrada previne quaisquer equívoco que possa vir do usuário no momento da inserção do dado, seja ele um código de área inválido ou a quantidade de dígitos do telefone, mantendo a integridade do conteúdo.
</p>

<figure>
    <img src='https://media.licdn.com/dms/image/D4D12AQEyIosy2s2sXQ/article-inline_image-shrink_1500_2232/0/1716396143136?e=1721865600&v=beta&t=KlCF-oXrZhpzi5ARwkOQTyQaUol1HxyqZj-Gma8WhHM'>
    <figcaption style='font-size: 12px; color: gray; text-align: center;'>
       Classe para realizar validações de entrada.
    </figcaption>
</figure>


### Validação de DDD

<p style='text-align: justify;'>
    É possível realizar a verificar se o código de área (DDD) fornecido pelo usuário é válido no Brasil com uma lista predefinida.
</p>

<figure>
    <img src='https://media.licdn.com/dms/image/D4D12AQFHFCKuEBCYuA/article-inline_image-shrink_1500_2232/0/1716321747878?e=1721865600&v=beta&t=vEwHMT2QN_wswlpbQzzHScedv_AVIDU7f-cwaYH4VYw'>
    <figcaption style='font-size: 12px; color: gray; text-align: center;'>
       Lista de Strings para verificação de DDD válidos.
    </figcaption>
</figure>

<p style='text-align: justify;'>
    Este trecho percorre a Lista de Strings dddsBR verificando se em certa posição da entrada possui algum dos itens dessa Lista. Se não possuir, uma mensagem de erro é adicionada.
</p>


## Conclusão

<figure>
    <img src='https://media.licdn.com/dms/image/D4D12AQFRgGls0nxlSQ/article-inline_image-shrink_1000_1488/0/1716392219343?e=1721865600&v=beta&t=MRG-nq4_ziS9ncltXTndOkqA4O8drQ_zZ4FSp4hNuD0'>
</figure>

<p style='text-align: justify'>
O uso de máscaras nos campos de entrada é essencial para assegurar a precisão e uniformidade dos dados. O exemplo de código oferecido demonstra uma maneira eficaz de aplicar essas máscaras a números de telefone, eliminando caracteres indesejados, verificando padrões específicos e formatando os números conforme os padrões brasileiros. Essas etapas não só auxiliam na manutenção da consistência dos dados, mas também aprimoram a experiência do usuário ao fornecer um retorno imediato sobre o formato correto dos dados.</p>
