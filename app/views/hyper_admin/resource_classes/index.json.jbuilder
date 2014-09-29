json.array! @resource_classes do |resource_class|
  real_resource = resource_class.resource_class

  json.menu_label real_resource.model_name.human(count: 2)
  json.singular real_resource.model_name.singular
  json.singular_human real_resource.model_name.human(count: 1)
  json.plural real_resource.model_name.plural
  json.plural_human real_resource.model_name.human(count: 2)
end
