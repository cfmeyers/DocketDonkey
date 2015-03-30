#DocketDonkey 
A Portal for Downloading Massachusetts Housing Court Data

![DocketDonkey FrontPage](https://raw.githubusercontent.com/cfmeyers/DocketDonkey/master/app/assets/images/frontpage_not_logged_in.png)

##Motivation

In Massachusetts, landlords and banks use the Massachusetts Housing Court to evict people from homes for non-payment of rent or after a foreclosure. The 2008 Financial Crisis made these kinds of cases prominent in the public eye.

A record of all these cases is available at http://www.masscourts.org/ . However, due to limited resources, the official website lacks an API, and each case must be accessed individually (through an elaborate javascript-heavy interface using a minimum of 6 clicks). There is no bulk download option.

##Capabilities

##Todo

-  [X]  Add link root to title 

-  [X]  Move csv parsing code from seeds.rb to library 

-  [X]  Write tests for csv parsing code

-  [X]  Write description for readme

-  [X]  Make an ArchivedClassLoader class

  -  [X]  ensure it checks for duplicate cases, loads the case that's most recent or has the most fields

-  [X]  Make a rake task that loads all archived classes

-  [X]  add gbls.org, cwjc.org, sccls.org, njc-ma.org, nejc.org, vlp.net

-  [ ] make export to excel faster for large numbers of cases

-  [ ] fix export to excel workbook for registered user

-  [ ] implement search by attorney feature

-  [ ] fix nginx so www.docketdonkey.com redirects to http://docketdonkey.com


