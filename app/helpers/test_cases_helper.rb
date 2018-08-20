module TestCasesHelper
  def read_test_cases test_suit_id
    test_cases = []
    @big_id_tc = 0
    filename = "test_suit" + test_suit_id + ".xml"
    Dir.glob("lib/xml/user#{current_user.id}/test_suites/test_suit#{test_suit_id}/test_case*.xml").each do |file|
      test_suit_doc = Nokogiri::XML(File.open(file))
      test_suit_doc.xpath("TestCase").each do |tc|
        test_case = TestCase.new
        test_case.name = tc.at_xpath("Name").text
        test_case.id = tc.at_xpath("Id").text
        @big_id_tc = @big_id_tc > test_case.id ? @big_id_tc : test_case.id
        test_cases << test_case
      end
    end
    return test_cases
  end

  def write_test_case_to_file_xml(test_case, test_suit_id)
    file_name = "test_suit" + test_suit_id + ".xml"
    builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
      xml.TestCase{
        xml.Id test_case.id
        xml.Name test_case.name
        xml.CreatedAt test_case.created_at
      }
    end

    File.open("lib/xml/user#{current_user.id}/test_suites/test_suit#{test_suit_id}/test_case#{test_case.id}.xml", "w+") do |file|
      file << builder.to_xml
    end
  end
end
