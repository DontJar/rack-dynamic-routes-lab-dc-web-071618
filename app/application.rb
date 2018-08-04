require "pry"

class Application

  @@items = [Item.new("apples", 3), Item.new("pears", 4.5)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_qry = req.path.split("/items/").last
        if @@items.map {|it| it.name}.include?(item_qry)
          item_type = @@items.find{ |thing| thing.name == item_qry}
          resp.write item_type.price
        else
          resp.write "Item not found"
          resp.status = 400
        end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
