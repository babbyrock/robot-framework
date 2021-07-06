*** Settings ***
Library     SeleniumLibrary
Library     String
*** Variables ***
${BROWSER}      chrome
${URL}          http://automationpractice.com/index.php
&{PESSOA}       nome=babby    sobrenome=rock

*** Keywords ***
#### Setup  e Teardown
Abrir navegador
    Open browser    ${URL}    ${BROWSER}

Fechar navegador
    Close Browser

### Passo-a-Passo
Acessar a página home do site
    Go To    http://automationpractice.com/index.php
    Title Should Be     My Store

Digitar o nome do produto "${PRODUTO}" no campo de Pesquisar
    Input Text    id=search_query_top   ${PRODUTO}

Clicar no botão Pesquisar
    Click Element    name=submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible    css=#center_column > h1
    Title Should Be                  Search - My Store
    Page Should Contain Image        xpath=//*[@id="center_column"]//*[@src='http://automationpractice.com/img/p/7/7-home_default.jpg']
    Page Should Contain Link         xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(), "Blouse")]

Conferir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait Until Element Is Visible    xpath=//*[@id="center_column"]/p[@class='alert alert-warning']
    Element Text Should Be           xpath=//*[@id="center_column"]/p[@class='alert alert-warning']   ${MENSAGEM_ALERTA}

Passar o mouse por cima da categoria "${CATEGORIA}" no menu principal superior de categorias
    Mouse Over                       xpath=//*[@id="block_top_menu"]//a[@title='${CATEGORIA}']
    Wait Until Element Is Visible    xpath=//*[@id="block_top_menu"]//a[@title='${CATEGORIA}']

Clicar na sub categoria "${SUBCATEGORIA}"
    Wait Until Element Is Visible    xpath=//*[@id="block_top_menu"]//a[@title="${SUBCATEGORIA}"]
    Click Element                    xpath=//*[@id="block_top_menu"]//a[@title="${SUBCATEGORIA}"]

Conferir se os produtos da sub-categoria "${SUBCATEGORIA}" foram mostrados na página
    Page Should Contain Element      xpath=//*[@id="center_column"]/h1/span[contains(text(),"Summer Dresses")]
    Page Should Contain Element      xpath=//*[@id="center_column"]//*[@src='http://automationpractice.com/img/p/1/2/12-home_default.jpg']
    Page Should Contain Element      xpath=//*[@id="center_column"]//*[@src='http://automationpractice.com/img/p/1/6/16-home_default.jpg']
    Page Should Contain Element      xpath=//*[@id="center_column"]//*[@src='http://automationpractice.com/img/p/2/0/20-home_default.jpg']

Clicar no botão "Add to cart" do produto
    Wait Until Element Is Visible    xpath=//*[@id="center_column"]//img[@title="Faded Short Sleeve T-shirts"]
    Click Element                    xpath=//*[@id="center_column"]//img[@title="Faded Short Sleeve T-shirts"]
    Wait Until Element Is Visible    xpath=//*[@id="add_to_cart"]/button
    Click Button                     xpath=//*[@id="add_to_cart"]/button

Clicar no botão "Proceed to checkout"
    Wait Until Element Is Visible    xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]
    Click Element                     xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

Conferir se o produto "${SUBCATEGORIA}" foi adicionado no carrinho com seus devidos dados e valores
    Wait Until Element Is Visible    xpath=//*[@id="cart_title"][contains(text(),"Shopping-cart summary")]
    Element Text Should Be           xpath=//*[@id="product_1_1_0_0"]//p[@class="product-name"]     Faded Short Sleeve T-shirts
    Element Text Should Be           xpath=//*[@class="cart_unit"]/*[@class="price"]/span           $16.51
    Element Text Should Be           xpath=//*[@id="total_price"]                                   $18.51

Adicionar o produto "t-shirt" no carrinho
    Digitar o nome do produto "t-shirt" no campo de Pesquisar
    Clicar no botão Pesquisar
    Clicar no botão "Add to cart" do produto
    Clicar no botão "Proceed to checkout"

Excluir o produto do carrinho
    Click Element         xpath=//*[@class="cart_quantity_delete"]

Conferir se o carrinho fica vazio
    Wait Until Element Is Visible    xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]
    Element Text Should Be           xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]     Your shopping cart is empty.

Clicar no botão superior direito "Sign in"
    Click Element    xpath=//*[@id="header"]//*[@class="login"][contains(text(),"Sign in")]

Criar um email customizado
    [Arguments]   ${NOME}   ${SOBRENOME}
    ${STRING_ALEATORIA}     Generate Random String
    ${CUSTOM_EMAIL}         Set Variable    ${NOME}${SOBRENOME}${STRING_ALEATORIA}@email.com
    [Return]                ${CUSTOM_EMAIL}
Informar um e-mail válido
    Wait Until Element Is Visible   id=email_create
    ${EMAIL}    Criar um email customizado    ${PESSOA.nome}    ${PESSOA.sobrenome}
    Input Text                      id=email_create    ${EMAIL}

Clicar no botão "Create na account"
    Click Button    id=SubmitCreate

Preencher os dados obrigatórios
    Wait Until Element Is Visible   xpath=//*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
    Click Element    id=id_gender1
    Input Text       id=customer_firstname    Bárbara
    Input Text       id=customer_lastname     Maria
    Input Text       id=passwd                qualquercoisa
    Input Text       id=firstname             Robot
    Input Text       id=lastname              Framework
    Input Text       id=address1              Rua Framework, Bairro Robot
    Input Text       id=city                  Fortaleza
    Input Text       id=postcode              66666
    Input Text       id=phone_mobile          99988877
    Input Text       id=alias                 Rua Robot, Bairro Framework
    Set Focus To Element         id=id_state
    Select From List By Index    id=id_state      9
    Set Focus To Element         id=id_state
    Select From List By Index    id=id_country    1

Clicar em "Register" para finalizar o cadastro
    Click Button    id=submitAccount
