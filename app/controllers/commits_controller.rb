class CommitsController < ApplicationController
  include TestCasesHelper
  def commit
    test_cases = params["test_cases"]
    test_suit = TestSuit.new
    test_suit.id = params["test_suit"]["id"]
    test_suit.name = params["test_suit"]["name"]

    content = params["content_commit"]

    Git.configure do |config|
      config.git_ssh = 'git@github.com:vovanquang12cntt/itv-bottest.git'
    end

    g = Git.open(working_dir = "~/Desktop/data-bottest/", :log => Logger.new(STDOUT))
    g.config('user.name', ENV['GIT_USERNAME'])
    g.config('user.email', ENV['GIT_EMAIL'])
    g.branch('data-bottest')
    g.config('remote.https.push', 'refs/heads/master:refs/heads/master')
    JSON.parse(test_cases).each do |tc|
      updated_field_test_case tc, test_suit.id
      g.add "user#{current_user.id}/test_suites/test_suit#{test_suit.id}/test_case#{tc['id']}.xml"
    end
    # g.commit "Test Case #{@test_case.name} just add by #{current_user.name}"
    g.commit "#{content}"
    # debugger
    g.push(remote = 'https', branch = 'data-bottest', opts = {})

    render html: "Commit successfully!!"
  end
end
