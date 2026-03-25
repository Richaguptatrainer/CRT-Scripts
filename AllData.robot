*** Settings ***
Resource                      ../resources/common.robot
Library                       DataDriver    reader_class=TestDataApi    name=Leads.csv    #iterates through the Leads csv
Suite Setup                   Setup Browser
Suite Teardown                End suite
Test Template                 Entering A Lead With Data

*** Test Cases ***
Entering A Lead With Data with ${First Name}    ${Last Name}    ${Phone}    ${Company}    ${Website}
    [Tags]                    AllData

*** Keywords ***
Entering A Lead With Data
    [Arguments]               ${First Name}    ${Last Name}    ${Phone}    ${Company}    ${Website}
    [tags]                    Lead
    Home
    LaunchApp                 Sales

    ClickText       Leads
    VerifyText      Change Owner
    ClickText       New                         partial_match=False
    VerifyText      Lead Information
    UseModal        On                          # Only find fields from open mod                        # Only find fields from open modal dialog
   TypeText        First Name                  ${First Name}
    TypeText        Last Name                   ${Last Name}
    Picklist        Lead Status                 Open - Not Contacted
    TypeText        Phone                       ${Phone}                    First Name
    TypeText        Company                     ${Company}                  Last Name
    TypeText        Website                     ${Website}
    Picklist        Lead Source                 Web
    ClickText       Save                        partial_match=False
    UseModal        Off
    Sleep           1
    ClickText       Details
    VerifyField     Phone                       ${phone}
    VerifyField     Company                     ${Company}
    VerifyField     Website                     ${Website}

# delete lead
     LaunchApp       Sales
    ClickText       Leads
    ${fullName}=    Catenate                    ${First Name}               ${Last Name}
    ClickText       ${fullName}
    ClickText       Show more actions
    ClickText       Delete
    UseModal        On
    ClickText       Delete
    UseModal        Off
