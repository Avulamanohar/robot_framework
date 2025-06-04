*** Settings ***
Library           AppiumLibrary
Library           Collections
Suite Setup       Start Appium Session
Suite Teardown    Close Appium Session
Test Setup        Accept Permissions
Test Teardown     Log Activity And Screenshot

*** Variables ***
${APPIUM_SERVER_URL}          http://localhost:4723
${PLATFORM_NAME}              Android
${AUTOMATION_NAME}            uiautomator2
${DEVICE_NAME}                %{DEVICE_NAME}
${UDID}                       %{UDID}
${APP_PACKAGE}                com.FetalLifeBusiness.FetalLifeBusiness
${APP_ACTIVITY}               crc647a6fce0f140131eb.SplashActivity
${APP_WAIT_ACTIVITY}          crc647a6fce0f140131eb.*
${LANGUAGE}                   en
${LOCALE}                     US
${AUTO_GRANT_PERMISSIONS}     ${TRUE}
${EMAIL}                      imommy@mail.com
${PASSWORD}                   1234

*** Test Cases ***
Test Full Application Flow
    Login
    Accept Permissions
    Change Language
    Record Weight    81
    Record Blood Pressure    120    80
    Record Temperature    98
    Record Blood Oxygen    100
    Record Blood Sugar    100    230    200
    Log Contractions
    Log Baby Kick Count
    Submit Contact Us Form
    Track Baby Growth

Test Open Search Activity
    ${activity}=    Get Activity
    Should Match Regexp    ${activity}    crc647a6fce0f140131eb.*

*** Keywords ***
Start Appium Session
    Open Application    ${APPIUM_SERVER_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    udid=${UDID}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    appWaitActivity=${APP_WAIT_ACTIVITY}    language=${LANGUAGE}    locale=${LOCALE}    autoGrantPermissions=${AUTO_GRANT_PERMISSIONS}
    Set Appium Timeout    10s

Close Appium Session
    Close Application

Accept Permissions
    ${allow_button}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//android.widget.Button[@text="Allow"]    timeout=5s
    Run Keyword If    ${allow_button}    Click Element    xpath=//android.widget.Button[@text="Allow"]
    Run Keyword If    ${allow_button}    Sleep    1s

Login
    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text="Username"]    timeout=10s
    Input Text    xpath=//android.widget.EditText[@text="Username"]    ${EMAIL}
    Input Text    xpath=//android.widget.EditText[@text="Password"]    ${PASSWORD}
    Click Element    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout[2]

Change Language
    Wait Until Element Is Visible    xpath=//android.widget.ImageButton[@content-desc="Open navigation drawer"]    timeout=5s
    Click Element    xpath=//android.widget.ImageButton[@content-desc="Open navigation drawer"]
    Click Element    xpath=//android.widget.Button[@text="English"]
    Click Element    xpath=//android.widget.Button[@text="Hindi"]
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button1"]
    Click Element    xpath=//android.widget.ImageButton[@content-desc="Open navigation drawer"]
    Click Element    xpath=//android.widget.Button[@text="Hindi"]
    Click Element    xpath=//android.widget.Button[@text="English"]
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button1"]

Navigate Back
    Wait Until Element Is Visible    xpath=//android.widget.ImageButton[@content-desc="Navigate up"]    timeout=5s
    Click Element    xpath=//android.widget.ImageButton[@content-desc="Navigate up"]

Record Weight
    [Arguments]    ${weight}
    Wait Until Element Is Visible    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[1]/android.view.ViewGroup    timeout=10s
    Click Element    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[1]/android.view.ViewGroup
    Wait Until Element Is Visible    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout    timeout=5s
    Click Element    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    timeout=5s
    Input Text    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    ${weight}
    Click Element    xpath=//android.widget.TextView[@text="Ok"]
    Navigate Back

Record Blood Pressure
    [Arguments]    ${systolic}    ${diastolic}
    Wait Until Element Is Visible    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[2]/android.view.ViewGroup    timeout=10s
    Click Element    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[2]/android.view.ViewGroup
    Wait Until Element Is Visible    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout    timeout=5s
    Click Element    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    timeout=5s
    Input Text    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    ${systolic}
    Input Text    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[4]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    ${diastolic}
    Click Element    xpath=//android.widget.TextView[@text="Ok"]
    Navigate Back

Record Temperature
    [Arguments]    ${temperature}
    Wait Until Element Is Visible    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup    timeout=10s
    Click Element    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup
    Wait Until Element Is Visible    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout    timeout=5s
    Click Element    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    timeout=5s
    Input Text    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    ${temperature}
    Click Element    xpath=//android.widget.TextView[@text="Ok"]
    Navigate Back

Record Blood Oxygen
    [Arguments]    ${oxygen}
    Wait Until Element Is Visible    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[4]/android.view.ViewGroup    timeout=10s
    Click Element    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[4]/android.view.ViewGroup
    Wait Until Element Is Visible    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout    timeout=5s
    Click Element    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    timeout=5s
    Input Text    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    ${oxygen}
    Click Element    xpath=//android.widget.TextView[@text="Ok"]
    Navigate Back

Record Blood Sugar
    [Arguments]    ${breakfast}    ${lunch}    ${dinner}
    Wait Until Element Is Visible    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[5]/android.view.ViewGroup    timeout=10s
    Click Element    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[5]/android.view.ViewGroup
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[4]/android.view.ViewGroup/android.widget.FrameLayout    timeout=10s
    Click Element    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[4]/android.view.ViewGroup/android.widget.FrameLayout
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    timeout=5s
    Input Text    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    ${breakfast}
    Click Element    xpath=//android.widget.TextView[@text="Ok"]
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[8]/android.view.ViewGroup/android.widget.FrameLayout    timeout=10s
    Click Element    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[8]/android.view.ViewGroup/android.widget.FrameLayout
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    timeout=5s
    Input Text    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    ${lunch}
    Click Element    xpath=//android.widget.TextView[@text="Ok"]
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[12]/android.view.ViewGroup/android.widget.FrameLayout    timeout=10s
    Click Element    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[12]/android.view.ViewGroup/android.widget.FrameLayout
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    timeout=5s
    Input Text    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.FrameLayout[3]/android.view.ViewGroup/android.view.ViewGroup/android.widget.EditText    ${dinner}
    Click Element    xpath=//android.widget.TextView[@text="Ok"]
    Navigate Back
Log Contractions
    Wait Until Element Is Visible    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[6]/android.view.ViewGroup    timeout=10s
    Click Element    xpath=//androidx.viewpager.widget.ViewPager/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[3]/android.view.ViewGroup/android.widget.FrameLayout[6]/android.view.ViewGroup
    Wait Until Element Is Visible    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout    timeout=5s
    Click Element    xpath=//android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ImageView    timeout=5s
    Click Element    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ImageView
    Sleep    5s
    Click Element    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ImageView
    Click Element    xpath=//android.widget.TextView[@text="Ok"]
    Sleep    5s
    Navigate Back

Log Baby Kick Count
    Wait Until Element Is Visible    xpath=//android.widget.HorizontalScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout[1]/android.view.ViewGroup/android.widget.ImageView    timeout=10s
    Click Element    xpath=//android.widget.HorizontalScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout[1]/android.view.ViewGroup/android.widget.ImageView
    FOR    ${i}    IN RANGE    3
        Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[2]    timeout=5s
        Click Element    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[2]
    END  
    FOR    ${i}    IN RANGE    3
        Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[1]    timeout=5s
        Click Element    xpath=//android.widget.FrameLayout[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/bottomtab.navarea"]/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ImageView[1]
        Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="android:id/button2"]    timeout=5s
        Click Element    xpath=//android.widget.Button[@resource-id="android:id/button2"]
    END
    Navigate Back

Submit Contact Us Form
    Wait Until Element Is Visible    xpath=(//android.widget.ImageView[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/navigation_bar_item_icon_view"])[3]    timeout=10s
    Click Element    xpath=(//android.widget.ImageView[@resource-id="com.FetalLifeBusiness.FetalLifeBusiness:id/navigation_bar_item_icon_view"])[3]
    Click Element    xpath=(//android.widget.TextView[@text="Contact Us"])[2]
    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text="Subject"]    timeout=5s
    Input Text    xpath=//android.widget.EditText[@text="Subject"]    Rahul
    Input Text    xpath=//android.widget.EditText[@text="Comments, suggestions and recommendations."]    Thank you !
    Click Element    xpath=//android.widget.TextView[@text="Send"]
    Switch To Context    NATIVE_APP
    Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="android:id/button2"]    timeout=10s
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button2"]

Track Baby Growth
    Wait Until Element Is Visible    xpath=//android.widget.HorizontalScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout[2]/android.view.ViewGroup/android.widget.ImageView    timeout=10s
    Click Element    xpath=//android.widget.HorizontalScrollView/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout[2]/android.view.ViewGroup/android.widget.ImageView

    Swipe    500    200    500    1000    1000
    Swipe    500    1000    500    200    1000
Log Activity And Screenshot
    ${activity}=    Get Activity
    Log    Current Activity: ${activity}
    Capture Page Screenshot    filename=activity_${activity}.png