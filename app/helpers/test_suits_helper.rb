module TestSuitsHelper
  def write_test_suite_to_file_xml test_suit
    builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
      xml.TestSuit{
        xml.Id test_suit["id"]
        xml.Name test_suit["name"]
        xml.UserId test_suit["user_id"]
        xml.CreatedAt test_suit["created_at"]
      }
    end
    test_suit_folder = "test_suit#{test_suit['id']}"
    Dir.mkdir("#{Settings.dir_store_data}/user#{current_user.id}/test_suites/#{test_suit_folder}") unless File.exist?("#{Settings.dir_store_data}/user#{current_user.id}/test_suites/#{test_suit_folder}")

    File.open("#{Settings.dir_store_data}/user#{current_user.id}/test_suites/#{test_suit_folder}/test_suit.xml", "w+") do |file|
      file << builder.to_xml
    end
  end
end
