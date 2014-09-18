def infer_type_from_attribute(resource_class, attribute)
  return :email if attribute == "email"
  return :url   if attribute == "url"

  resource_class.columns_hash[attribute].type
end

json.menu_label @resource_class.model_name.human(count: 2)
json.singular @resource_class.model_name.singular
json.singular_human @resource_class.model_name.human(count: 1)
json.plural @resource_class.model_name.plural
json.plural_human @resource_class.model_name.human(count: 2)

attributes = @resource_class.attribute_names.map do |attr|
  {
    key: attr,
    human: @resource_class.human_attribute_name(attr),
    type: infer_type_from_attribute(@resource_class, attr)
  }
end
json.attributes attributes
