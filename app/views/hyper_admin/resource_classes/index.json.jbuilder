json.array! @resource_classes do |resource_class|
  json.menu_label resource_class.model_name.human(count: 2)
  json.singular resource_class.model_name.singular
  json.plural resource_class.model_name.plural
end
