module LayoutsHelper
	def read_layout
    @layouts = []
    @big_id = 0
    
    Dir.glob("#{Settings.dir_store_data}/user#{current_user.id}/layout/*/layout.xml").each do |file|

      doc = Nokogiri::XML(File.open(file))
      doc.xpath("LayoutModel").each do |ls|
        objLayoutModel = {}
        objLayoutModel["id"] = ls.at_xpath("Id").text
        @big_id =  @big_id > objLayoutModel["id"].to_i ? @big_id : objLayoutModel["id"].to_i
        objLayoutModel["name"] = ls.at_xpath("Name").text
        objLayoutModel["width"] = ls.at_xpath("Width").text
        objLayoutModel["height"] = ls.at_xpath("Height").text
        objLayoutModel["user_id"] = ls.at_xpath("UserId").text
        objLayoutModel["created_at"] = ls.at_xpath("CreatedAt").text

        @layouts << objLayoutModel
        # debugger
      end
    end
  end

  # def read_layout_user
  #   @layout_user = []
  #   @layouts.each do |ls|
  #     if ls["user_id"] == current_user.id.to_s
  #       @layout_user << ls
  #     end
  #   end
  # end
  def write_layouts layouts
  	# debugger
    builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
      xml.LayoutModel{
      	# debugger
        xml.Id layouts["id"].to_s	
        xml.Name layouts["name"]
        xml.Width layouts["width"]
        xml.Height layouts["height"]
        xml.UserId layouts["user_id"]
        xml.CreatedAt layouts["created_at"]
        # debugger

      }
    end
    layouts_folder = "layouts#{layouts['id']}"
    Dir.mkdir("#{Settings.dir_store_data}/user#{current_user.id}/layout/#{layouts_folder}") unless File.exist?("#{Settings.dir_store_data}/user#{current_user.id}/layout/#{layouts_folder}")

    File.open("#{Settings.dir_store_data}/user#{current_user.id}/layout/#{layouts_folder}/layout.xml", "w+") do |file|
    	# debugger
      file << builder.to_xml
    end
  end
end
