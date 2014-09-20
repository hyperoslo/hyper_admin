json.array! @resources do |resource|
  json.partial! 'admin/resources/resource', resource: resource
end
