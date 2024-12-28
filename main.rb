require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome

def main(driver)
  driver.get 'https://orteil.dashnet.org/cookieclicker/'

  sleep(5)

  driver.execute_script('localStorage.setItem("CookieClickerLang","EN")')

  wait = Selenium::WebDriver::Wait.new(timeout: 20)

  wait.until { driver.find_element(css: '.langSelectButton') }


  lang_button = driver.find_element(css: '.langSelectButton')

  lang_button.click

  sleep(2)
 
  wait.until { driver.find_element(id: "bigCookie").displayed? }

  button = driver.find_element(id: "bigCookie")

  driver.execute_script('Game.lastClick -= 2000') 

  driver.execute_script('purchases = setInterval(() => { let e = Game.ObjectsById; let l = e.filter(e => e.price <= Game.cookies); if (l.length > 0) { l[Math.floor(Math.random() * l.length)].buy(); } }, 1000);')

  start_time = Time.now

  while Time.now - start_time < 600 # Run for 10 minutes

    button.click

    sleep(0.1)  

  end

  driver.execute_script('Game.toSave = true')

  sleep(2)

  driver.quit

end

main(driver)
