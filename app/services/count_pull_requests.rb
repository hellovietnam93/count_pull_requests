require "csv"

class CountPullRequests
  CSV_HEADER = ["#", "Author", "PR ID", "Pull Request", "Bugs","Line of code +", "Line of code -"]

  attr_accessor :driver, :pull_requests, :data_export_to_csv, :repository_names, :csv_header, :wait, :filters_by_months

  def initialize args
    @user = args[:user]
    @repository = args[:repository]
    @query = args[:query]
    init_selenium
    load_conditions
  end

  def call
    login_to_github
    init_github_repo
    get_list_pull_requests
    driver.quit
  end

  private

  def init_selenium
    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to "https://github.com/login"
    @wait = Selenium::WebDriver::Wait.new timeout: 1000
  end

  def load_conditions
    @filters_by_month = @query.content
  end

  def init_github_repo
    @url = "#{@repository.name}/pulls"
    @file_name = "tmp/test_count.csv"
  end

  def login_to_github
    email = driver.find_element name: "login"
    email.send_keys @user.git_account

    password = driver.find_element name: "password"
    password.send_keys @user.git_password

    submit = driver.find_element name: "commit"
    submit.click
  end

  def init_instances
    @pull_requests = []
    @data_export_to_csv = []
    @pr_improts = []
  end

  def get_list_pull_requests
    driver.get @url
    filters_pull_request_by_query
    init_instances
    sleep 2

    button_next = begin
      driver.find_element class: "next_page"
    rescue Exception => e
      true
    end

    while button_next
      sleep 2
      link_pull_requests = driver.find_elements :xpath, "//a[@class='link-gray-dark v-align-middle no-underline h4 js-navigation-open']"

      link_pull_requests.each do |link_pull_request|
        pull_requests << link_pull_request.attribute("href")
      end

      break if button_next == true
      break if button_next.tag_name == "span"

      button_next.click
      sleep 4
      button_next = driver.find_element class: "next_page"
    end
    count_total_additional
  end

  def filters_pull_request_by_query
    filter_element = driver.find_element id: "js-issues-search"
    filter_element.clear
    filter_element.send_keys @filters_by_month
    filter_element.submit
  end

  def count_total_additional
    pull_requests.each_with_index do |pull_request, index|
      driver.get "#{pull_request}/files"
      wait.until {driver.find_element :xpath, '//*[@id="files_bucket"]/div[3]/div/span/span[1]'}
      additional_element = driver.find_element :xpath, '//*[@id="files_bucket"]/div[3]/div/span/span[1]'
      deletion_element = driver.find_element :xpath, '//*[@id="files_bucket"]/div[3]/div/span/span[2]'
      author = driver.find_element(:class, "head-ref").find_element(:class, "user").text rescue nil
      additional = additional_element.text.gsub(",", "").to_i
      deletion = deletion_element.text.gsub("−", "-").to_i
      pr_id = pull_request.delete @url
      data_export_to_csv << [index + 1, author, pr_id, pull_request, 0, additional, deletion]
      @pr_improts << PullRequest.new(author: author, pr_id: pr_id, pull_request: pull_request, plus_code: additional, minus_code: deletion, query_condition_id: @query.id)
    end
    PullRequest.import @pr_improts
  end

  def export_data_to_csv file_name
    CSV.open(file_name, "wb") do |csv|
      csv << CSV_HEADER
      data_export_to_csv.each do |data|
        csv << data
      end
    end

    puts "export csv success !"
  end

  def export_data_to_csv_pr file_name
    CSV.open(file_name, "wb") do |csv|
      pull_requests.each do |pull_request|
        csv << [pull_request]
      end
    end

    puts "export csv success !"
  end
end
