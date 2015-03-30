#DocketDonkey 
A Portal for Downloading Massachusetts Housing Court Data

![DocketDonkey FrontPage](https://raw.githubusercontent.com/cfmeyers/DocketDonkey/master/app/assets/images/frontpage_not_logged_in.png)

##Motivation

In Massachusetts, landlords and banks use the Massachusetts Housing Court to evict people from homes for non-payment of rent or after a foreclosure. The 2008 Financial Crisis made these kinds of cases prominent in the public eye.

A record of all these cases is available at http://www.masscourts.org/ . However, due to limited resources, the official website lacks an API, and each case must be accessed individually (through an elaborate javascript-heavy interface using a minimum of 6 clicks). There is no bulk download option.

##Capabilities

A user can (anonymously) download all the housing cases from a range of dates they specify.  The resulting CSV will have a row for each case in that range, with each row containing all the information the user would have been able to get by navigating to that case using the masscourts.org website, with the exception of information identifying defendants or addresses of the homes in question.  

If the user belongs to a recognized Legal Aid agency in Massachusetts (as identified by their email address), they can register with DocketDonkey.  When logged in they will be able to download all of the information, including publically available information about defendants.

##Example CSV (no defendant information)

case_number|case_number_integer|case_type|case_status|status_date|file_date|plaintiff_name_original|plaintiff_name_guess|plaintiff_attorney_name|defendants_self_represented|case_outcome|case_outcome_date
-----------|-------------------|---------|-----------|-----------|---------|-----------------------|--------------------|-----------------------|---------------------------|------------|-----------------
14H85SP005106|5106|Housing Court Summary Process|Closed|2014-12-18|2014-12-03|Matheson Apts LLC|Matheson Apts LLC|"Raphaelson, Esq., Henry (411971)"|true|R 41(a)(1) Voluntary Dismissal|2014-12-18
14H85SP005107|5107|Housing Court Summary Process|Active|2014-12-03|2014-12-03|F&R LLC|F&R LLC|"Raphaelson, Esq., Henry (411971)"|false|Agreement for Judgment|2015-01-22

##How It's Built

###Data

The data was scraped from masscourts.org using Python and a [Selenium](https://selenium-python.readthedocs.org/) webdriver.  The scraped data was loaded into CSV files to be parsed at a later date.  The scraper was sprinkeled with plenty of `Time.sleep()`'s in order to be considerate of the masscourts.org's server.

The code hasn't yet been published on github.  I'm looking at porting it over to  Node.js and a headless PhantomJS webdriver (so that I can run it on a DigitalOcean VPS).

###Parsing

###Site

-  Export to Excel:  For a detailed rundown of the headaches from adding this feature, see [this](http://blog.cfmeyers.com/2015/03/29/adding-export-to-excel-to-docketdonkey.html) blog post.

###Authentication

Used the [Devise](https://github.com/plataformatec/devise) gem for authentication, along with [SendGrid](https://sendgrid.com/) to send confirmation emails.  In order to keep users limited to Legal Aid agencies, User model validates email in [`User.rb`](https://github.com/cfmeyers/DocketDonkey/blob/master/app/models/user.rb):

~~~ruby
  validates :email, format: { with: /@(cla-ma.org|cfmeyers.com|mlac.org gbls.org|cwjc.org|sccls.org|njc-ma.org|nejc.org|vlp.net)/ , message:VALIDATION_ERROR_MESSAGE}
~~~

###Deployment

Deployed on a [DigitalOcean](https://www.digitalocean.com/) VPS using [Nginx](http://nginx.org/), [Passenger](https://github.com/phusion/passenger), [Postgresql](http://www.postgresql.org/), and [Capistrano](https://github.com/capistrano/capistrano).



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


