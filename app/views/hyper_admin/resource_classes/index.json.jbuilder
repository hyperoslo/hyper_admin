json.array! @resource_classes do |resource_class|
  json.menu_label resource_class.model_name.human(count: 2)
  json.singular resource_class.model_name.singular
  json.singular_human resource_class.model_name.human(count: 1)
  json.plural resource_class.model_name.plural
  json.plural_human resource_class.model_name.human(count: 2)

  attributes = resource_class.attribute_names.map do |attr|
    {
      attr.to_sym => resource_class.human_attribute_name(attr)
    }
  end
  json.attributes attributes.inject(&:merge)
end
