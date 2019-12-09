module RequestSpecHelper
  def body_json
    JSON.parse(response.body)
  end
end
