module ArticlesHelper
  def nikkei_value
    agent = Mechanize.new
    page = agent.get('https://finance.yahoo.co.jp/')
    nikkei = page.search('//*[@id="one-header"]/dl/dd[2]').text
    dif = page.search('//*[@id="one-header"]/dl/dd[1]').text
    nkvar = "#{nikkei}  (#{dif})"
  end
  def dow_value
    agent = Mechanize.new
    page = agent.get('https://finance.yahoo.co.jp/')
    dow = page.search('//*[@id="two-header"]/dl/dd[2]').text
    dif = page.search('//*[@id="two-header"]/dl/dd[1]').text
    dwvar = "#{dow}  (#{dif})"
  end
  def exchange_rate
    agent = Mechanize.new
    page = agent.get('https://finance.yahoo.co.jp/')
    exchange_rate = page.search('//*[@id="three-header"]/dl/dd').text
  end
end
