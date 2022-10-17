*** Settings ***
Documentation       A simple web scraper robot.
...                 Opens a website.
...                 Stores the web page text in a file in the output directory.
...                 Saves a screenshot of an element in the output directory.

Library             RPA.Browser.Selenium    auto_close=${false}
Library             RPA.FileSystem
Library             RPA.Excel.Files
Library             RPA.Tables
Library             RPA.Robocorp.WorkItems
Library             Collections


*** Variables ***
${SEARCH_TERM}      4cm Puzzlematte
${products}         Matten
${URL}              https://www.ju-sports.de/
${XLSX_PATH}        ${OUTPUT_DIR}${/}Ju-Sports.xlsx
${itemOne}          css:.box--basic:nth-child(1) .product--info


*** Tasks ***
Store Ju-sports Products
    Open website
    Click Element    xpath://html/body/div[1]/header/div[2]/nav/ul/li[2]/label
    Open result page
    Show most results
    Put Items into Excel File
    [Teardown]    Close Browser


*** Keywords ***
Reject Cookies
    Click Element If Visible    xpath://html/body/div[2]/div/div[2]/a[1]

Open website
    Open Available Browser    ${URL}
    Run Keyword And Ignore Error    Reject Cookies

Open result page
    Search for    ${SEARCH_TERM}

Search for
    [Arguments]    ${text}
    Input Text    name: sSearch    ${text}
    Press Keys    name: sSearch    ENTER

Show most results
    Select From List By Index    id:n    3

Put Items into Excel File
    Wait Until Element Is Visible    ${itemOne}

    Create Workbook    ${XLSX_PATH}
    Create Worksheet    ${products}

    ${i}=    Convert To Integer    1

    @{Table_Data_title}=    Create List
    @{Table_Data_descr}=    Create List
    @{Table_Data_price}=    Create List
    @{Table_Data_id}=    Create List

    ${elements}=    Get WebElements    css:.product--info
    Log    ${elements}
    FOR    ${item}    IN    @{elements}
        ${title}=    Wait Until Keyword Succeeds
        ...    3x
        ...    200ms
        ...    Get Text
        ...    css:.box--basic:nth-child(${i}) .product--title
        Append To List    ${Table_Data_title}    ${title}

        ${descr}=    Wait Until Keyword Succeeds
        ...    3x
        ...    200ms
        ...    Get Text
        ...    css:.product--box:nth-child(${i}) .product--description
        Append To List    ${Table_Data_descr}    ${descr}

        ${price}=    Wait Until Keyword Succeeds
        ...    3x
        ...    200ms
        ...    Get Text
        ...    css:.box--basic:nth-child(${i}) .price--default
        Append To List    ${Table_Data_price}    ${price}

        Append To List    ${Table_Data_id}    ${i}
        ${i}=    Evaluate    ${i}+1
        IF    ${i}==21            BREAK
        # ${endloop}=    Does Element Contain    css:.box--basic:nth-child(${i})    ${i}    ignore_case=False
        # ${break}    IF    1    ==    1    BREAK
    END
    Log List    ${Table_Data_title}
    &{Table_Data}=    Create Dictionary
    ...    ID=${Table_Data_id}
    ...    Titel=${Table_Data_title}
    ...    Preis=${Table_Data_price}
    ...    Beschreibung=${Table_Data_descr}

    ${table}=    Create Table    ${Table_Data}

    Append Rows To Worksheet    ${table}    name=${products}    header=True
    # Set cell format    2    A    1    name=Matten
    Save Workbook    overwrite=True

    Log    Yup, I'm there
