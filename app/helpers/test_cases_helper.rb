module TestCasesHelper
  def read_test_cases test_suit_id
    test_cases = []
    @big_id_tc = 0
    filename = "test_suit" + test_suit_id + ".xml"
    test_suit_doc = Nokogiri::XML(File.open("lib/xml/test_suits/#{filename}", "a+"))
    test_suit_doc.xpath("//TestCase").each do |tc|
      test_case = TestCase.new
      test_case.name = tc.at_xpath("Name").text
      test_case.id = tc.at_xpath("Id").text
      @big_id_tc = @big_id_tc > test_case.id ? @big_id_tc : test_case.id
      test_cases << test_case
    end
    return test_cases
  end

  def write_test_case_to_file_xml(test_cases, test_suit_id)
    file_name = "test_suit" + test_suit_id + ".xml"
    builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
      xml.TestSuit{
        xml.TestCases{
          test_cases.each do |tc|
            xml.TestCase{
              xml.Id tc.id
              xml.Name tc.name
              xml.CreatedAt tc.created_at
            }
          end
        }
      }
    end

    File.open("lib/xml/test_suits/#{file_name}", "w+") do |file|
      file << builder.to_xml
    end
  end
end
