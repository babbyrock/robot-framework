*** Settings ***
Library     SeleniumLibrary
*** Variables ***
${BROWSER}      chrome
${URL}          http://automationpractice.com/index.php
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
